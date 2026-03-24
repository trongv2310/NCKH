using System;
using System.Collections.Generic;
using System.Linq;

namespace DoAn_CauLong.DataMining
{
    public class TransactionDto
    {
        public int Tid { get; set; }
        public Dictionary<int, int> Items { get; set; } = new Dictionary<int, int>();
        public Dictionary<int, double> Utils { get; set; } = new Dictionary<int, double>();
        public double Tu { get; set; }
    }

    public class Element
    {
        public int Tid { get; set; }
        public double Eu { get; set; }
        public double Ru { get; set; }

        public Element(int tid, double eu, double ru) { Tid = tid; Eu = eu; Ru = ru; }
    }

    public class IList
    {
        public List<int> Itemset { get; set; }
        public Dictionary<string, List<Element>> Batches { get; set; } = new Dictionary<string, List<Element>>();
        public Dictionary<string, double> BatchSumEU { get; set; } = new Dictionary<string, double>();
        public Dictionary<string, double> BatchSumRU { get; set; } = new Dictionary<string, double>();

        public IList(List<int> itemset) { Itemset = itemset; }

        public void AddBatchData(string batchId, List<Element> elements)
        {
            Batches[batchId] = elements;
            BatchSumEU[batchId] = elements.Sum(e => e.Eu);
            BatchSumRU[batchId] = elements.Sum(e => e.Ru);
        }

        public void RemoveBatchData(string batchId)
        {
            Batches.Remove(batchId);
            BatchSumEU.Remove(batchId);
            BatchSumRU.Remove(batchId);
        }

        public double GetTotalEu() => BatchSumEU.Values.Sum();
        public double GetTotalRu() => BatchSumRU.Values.Sum();
    }

    public class TopKResult
    {
        public double Utility { get; set; }
        public List<int> Itemset { get; set; }
        public string ItemsetKey { get; set; }
    }

    public class VertTopKDS
    {
        private int _k;
        private int _winSize;
        private List<string> _slidingWindow = new List<string>();
        private Dictionary<string, List<TransactionDto>> _batchesData = new Dictionary<string, List<TransactionDto>>();
        private Dictionary<int, double> _globalTwu = new Dictionary<int, double>();
        private Dictionary<int, IList> _ilists = new Dictionary<int, IList>();
        private double _prevThreshold = 0;

        // Quản lý Top K thay vì heapq của Python
        private List<TopKResult> _topKBuffer = new List<TopKResult>();
        private HashSet<string> _itemsetsSet = new HashSet<string>();

        public VertTopKDS(int k, int winSize)
        {
            _k = k;
            _winSize = winSize;
        }

        private void AddToTopK(List<int> itemset, double utility)
        {
            var sortedItemset = new List<int>(itemset);
            sortedItemset.Sort();
            string key = string.Join(",", sortedItemset);

            if (_itemsetsSet.Contains(key)) return;

            if (_topKBuffer.Count < _k)
            {
                _topKBuffer.Add(new TopKResult { Utility = utility, Itemset = sortedItemset, ItemsetKey = key });
                _itemsetsSet.Add(key);
                _topKBuffer = _topKBuffer.OrderBy(x => x.Utility).ToList(); // Min ở index 0
            }
            else if (utility > _topKBuffer[0].Utility)
            {
                _itemsetsSet.Remove(_topKBuffer[0].ItemsetKey);
                _topKBuffer[0] = new TopKResult { Utility = utility, Itemset = sortedItemset, ItemsetKey = key };
                _itemsetsSet.Add(key);
                _topKBuffer = _topKBuffer.OrderBy(x => x.Utility).ToList();
            }
        }

        private double GetThreshold() => _topKBuffer.Count > 0 ? _topKBuffer[0].Utility : 0;

        private double GetTwu(int item) => _globalTwu.ContainsKey(item) ? _globalTwu[item] : 0;

        private void UpdateWindow(string bid, List<TransactionDto> batch)
        {
            if (_slidingWindow.Count >= _winSize)
            {
                string old = _slidingWindow[0];
                _slidingWindow.RemoveAt(0);

                foreach (var t in _batchesData[old])
                {
                    foreach (var i in t.Items.Keys)
                    {
                        if (_globalTwu.ContainsKey(i)) _globalTwu[i] -= t.Tu;
                    }
                }

                foreach (var ilist in _ilists.Values) ilist.RemoveBatchData(old);
                _batchesData.Remove(old);
            }

            _slidingWindow.Add(bid);
            _batchesData[bid] = batch;

            foreach (var t in batch)
            {
                foreach (var i in t.Items.Keys)
                {
                    if (!_globalTwu.ContainsKey(i)) _globalTwu[i] = 0;
                    _globalTwu[i] += t.Tu;
                }
            }

            var items = _globalTwu.Where(x => x.Value > 0).Select(x => x.Key).OrderBy(x => _globalTwu[x]).ThenBy(x => x).ToList();
            var order = items.Select((val, idx) => new { val, idx }).ToDictionary(x => x.val, x => x.idx);

            var temp = new Dictionary<int, List<Element>>();

            foreach (var t in batch)
            {
                var its = t.Items.Keys.Where(i => order.ContainsKey(i)).OrderBy(x => order[x]).ToList();
                if (its.Count == 0) continue;

                double ru = 0;
                for (int idx = its.Count - 1; idx >= 0; idx--)
                {
                    int i = its[idx];
                    double eu = t.Utils.ContainsKey(i) ? t.Utils[i] : 0;

                    if (!temp.ContainsKey(i)) temp[i] = new List<Element>();
                    temp[i].Add(new Element(t.Tid, eu, ru));
                    ru += eu;
                }
            }

            foreach (var kvp in temp)
            {
                if (!_ilists.ContainsKey(kvp.Key)) _ilists[kvp.Key] = new IList(new List<int> { kvp.Key });
                _ilists[kvp.Key].AddBatchData(bid, kvp.Value);
            }
        }

        private IList Construct(IList prefix, IList yIlist, double currentTh)
        {
            var newItemset = new List<int>(prefix.Itemset) { yIlist.Itemset[0] };
            var newIList = new IList(newItemset);
            var commonBatches = prefix.Batches.Keys.Intersect(yIlist.Batches.Keys).ToList();

            foreach (var b in commonBatches)
            {
                var ex = prefix.Batches[b];
                var ey = yIlist.Batches[b];
                int i = 0, j = 0;
                var res = new List<Element>();

                while (i < ex.Count && j < ey.Count)
                {
                    if (ex[i].Tid == ey[j].Tid)
                    {
                        res.Add(new Element(ex[i].Tid, ex[i].Eu + ey[j].Eu, ey[j].Ru));
                        i++; j++;
                    }
                    else if (ex[i].Tid < ey[j].Tid) i++;
                    else j++;
                }
                if (res.Count > 0) newIList.AddBatchData(b, res);
            }

            if (newIList.Batches.Count == 0 || (newIList.GetTotalEu() + newIList.GetTotalRu() < currentTh)) return null;
            return newIList;
        }

        private void VertMiner(IList currentIlist, int startIdx, List<IList> oneItemILists, double currentTh)
        {
            double eu = currentIlist.GetTotalEu();
            if (eu >= currentTh) AddToTopK(currentIlist.Itemset, eu);

            if (eu + currentIlist.GetTotalRu() < currentTh) return;

            for (int j = startIdx; j < oneItemILists.Count; j++)
            {
                var ixy = Construct(currentIlist, oneItemILists[j], currentTh);
                if (ixy != null) VertMiner(ixy, j + 1, oneItemILists, GetThreshold());
            }
        }

        public void ProcessBatch(string batchId, List<TransactionDto> batchTransactions)
        {
            UpdateWindow(batchId, batchTransactions);

            if (_slidingWindow.Count == _winSize)
            {
                var oneItemILists = _globalTwu.Where(x => x.Value >= _prevThreshold)
                                              .Select(x => x.Key).OrderBy(x => _globalTwu[x]).ThenBy(x => x)
                                              .Where(i => _ilists.ContainsKey(i)).Select(i => _ilists[i]).ToList();

                _topKBuffer.Clear();
                _itemsetsSet.Clear();

                foreach (var il in oneItemILists) AddToTopK(il.Itemset, il.GetTotalEu());

                double currentTh = GetThreshold();
                oneItemILists = oneItemILists.Where(il => GetTwu(il.Itemset[0]) >= currentTh).ToList();

                for (int i = 0; i < oneItemILists.Count; i++)
                    VertMiner(oneItemILists[i], i + 1, oneItemILists, currentTh);

                var commonBatches = _slidingWindow.Skip(1).ToList();
                if (commonBatches.Count > 0 && _topKBuffer.Count > 0)
                {
                    double minUtilCommon = _topKBuffer.Min(result =>
                    {
                        double utilCommon = 0;
                        var itemsetSet = new HashSet<int>(result.Itemset);
                        foreach (var bid in commonBatches)
                        {
                            foreach (var t in _batchesData[bid])
                            {
                                if (itemsetSet.IsSubsetOf(t.Items.Keys))
                                    utilCommon += result.Itemset.Sum(item => t.Utils.ContainsKey(item) ? t.Utils[item] : 0);
                            }
                        }
                        return utilCommon;
                    });
                    _prevThreshold = minUtilCommon;
                }
                else _prevThreshold = 0;
            }
        }

        public List<TopKResult> GetResults() => _topKBuffer.OrderByDescending(x => x.Utility).ToList();
    }
}