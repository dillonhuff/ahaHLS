#ifndef DBHC_ALGORITHM_H
#define DBHC_ALGORITHM_H

#include <algorithm>
#include <array>
#include <cassert>
#include <iostream>
#include <map>
#include <deque>
#include <list>
#include <forward_list>
#include <numeric>
#include <set>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>

#define DBG_ASSERT(x) assert(x)

namespace dbhc {

  template<typename T>
  int num_elems(std::vector<std::vector<T>>& v) {
    int i = 0;
    for (auto t : v) {
      i += t.size();
    }
    return i;
  }

  template<typename I>
  std::vector<unsigned> inds(const std::vector<I>& elems) {
    std::vector<unsigned> is(elems.size());
    std::iota(begin(is), end(is), 0);
    return is;
  }

  template<typename T>
  void concat(T& extend, const T& add) {
    extend.insert(end(extend), begin(add), end(add));
  }

  template<typename E, typename T>
  void remove(E e, T& t) {
    t.erase(std::remove(begin(t), end(t), e), end(t));
  }

  template<typename E, typename T>
  bool elem(E e, std::vector<T> t) {
    return std::find(begin(t), end(t), e) != end(t);
  }

  template<typename T>
  bool elem(T e, const std::unordered_set<T>& t) {
    return t.find(e) != end(t);
  }

  template<typename T>
  bool elem(T e, const std::deque<T>& t) {
    return std::find(begin(t), end(t), e) != end(t);
  }
  
  template<typename T>
  bool elem(T e, const std::set<T>& t) {
    return t.find(e) != end(t);
  }
  
  template<typename InputIt, typename OutputIt, typename F>
  OutputIt apply_between(InputIt s, InputIt e, OutputIt r, F f) {
    while (s != (e - 1)) {
      *r = f(*s, *(s + 1));
      ++r;
      ++s;
    }
    return r;
  }

  template<typename InputIt, typename F>
  void apply_between(InputIt s, InputIt e, F f) {
    if (s == e) { return; }
    while (s != (e - 1)) {
      f(*s, *(s + 1));
      ++s;
    }
  }
  
  template<typename InputIt, typename F>
  bool all_between(InputIt s, InputIt e, F f) {
    while (s != (e - 1)) {
      if (!f(*s, *(s + 1))) { return false; };
      ++s;
    }
    return true;
  }

  template<typename InputIt, typename F>
  bool any_between(InputIt s, InputIt e, F f) {
    while (s != (e - 1)) {
      if (f(*s, *(s + 1))) { return true; };
      ++s;
    }
    return false;
  }
  
  template<typename InputIt, typename F>
  void greedy_adjacent_chains(InputIt s, InputIt e, F f) {
    if (s == e) { return; }
    while (s < e - 1) {
      auto n = s + 1;
      bool found_adjacent = false;
      while (n < e) {
	if (f(*s, *n)) {
	  found_adjacent = true;
	  break;
	}
	n++;
      }
      if (found_adjacent) { std::swap(*(s + 1), *n); }
      s++;
    }
  }

  // Could use adjacent_find in place of this function, but I
  // found that the return policy of giving the first element of
  // the matching pair if a match occurs, and end otherwise made
  // iteration awkward when you want to construct new data structures
  // out of the subranges produced by calls to adjacent_find
  template<typename InputIt, typename F>
  std::pair<InputIt, InputIt> find_between(InputIt s, InputIt e, F f) {
    while (s != (e - 1)) {
      if (f(*s, *(s + 1))) { return std::pair<InputIt, InputIt>(s, s + 1); }
      ++s;
    }
    return std::pair<InputIt, InputIt>(s, e);
  }

  template<typename I, typename F>
  std::vector<std::vector<I>> split_by(const std::vector<I>& elems, F f) {
    std::vector<std::vector<I>> split;
    split_by(elems, split, f);
    return split;
  }
  
  template<typename I, typename F>
  void split_by(const std::vector<I>& elems, std::vector<std::vector<I>>& res, F f) {
    auto it = elems.begin();
    auto not_f = [&f](const I& i, const I& j) { return !f(i, j); };
    while (it != elems.end()) {
      auto r = find_between(it, end(elems), not_f);
      res.push_back(std::vector<I>(it, r.first + 1));
      it = r.second;
    }
  }

  template<typename I, typename F>
  std::vector<std::vector<I>> group_unary(const std::vector<I>& elems, F f) {
    std::vector<std::vector<I>> grouped;
    auto match = [&f](const I& i, const I& j) { return f(i) == f(j); };
    split_by(elems, grouped, match);
    return grouped;
  }

  template<typename I, typename F>
  void delete_if(I& c, F f) {
    c.erase(remove_if(begin(c), end(c), f), end(c));
  }

  template<typename T>
  void subtract(T& a, const T& b) {
    delete_if(a,
	      [&b](const typename T::value_type& i)
	      { return std::find(begin(b), end(b), i) != end(b); });
  }

  template<typename T, typename Q>
  std::pair<T, Q>
  mk_pair(T t, Q q) { return std::pair<T, Q>(t, q); }

  // TODO: Figure out why this implementation always calls
  // the default constructor
  template<typename InputIt1, typename InputIt2, typename OutputIt>
  OutputIt
  zip(InputIt1 ps, InputIt1 pe, InputIt2 qs, OutputIt r) {
    while (ps != pe) {
      *r = mk_pair(*ps, *qs);
      ++ps;
      ++qs;
      ++r;
    }
    return r;
  }

  template<typename T, typename F>
  void drop_while(T& t, F f) {
    auto r = std::find_if_not(begin(t), end(t), f);
    auto s = std::distance(begin(t), r);
    std::rotate(begin(t), r, end(t));
    t.erase(begin(t) + t.size() - s, end(t));
  }

  template<typename T, typename F>
  void take_while(T& t, F f) {
    auto r = find_if_not(begin(t), end(t), f);
    auto s = distance(begin(t), r);
    t.erase(begin(t) + s, end(t));
  }

  template<typename T, typename F>
  std::vector<T> select(const std::vector<T>& v, F f) {
    std::vector<T> selected;
    for (auto e : v) {
      if (f(e)) {
	selected.push_back(e);
      }
    }
    return selected;
  }

  template<typename I, typename P>
  std::vector<unsigned>
  select_neighbors(std::vector<unsigned>& inds,
		   const std::vector<I>& elems,
		   std::vector<unsigned>& buf,
		   unsigned next,
		   P p) {

    std::vector<unsigned> inds_to_remove;

    for (unsigned i = 0; i < inds.size(); i++) {
      unsigned u = inds[i];
      if (u != next && p(elems[u], elems[next])) {
    	buf.push_back(u);
    	inds_to_remove.push_back(u);
      }
    }

    return inds_to_remove;
  }
  
  template<typename I, typename P>
  std::vector<unsigned>
  dfs_by_neighbors(std::vector<unsigned>& inds, const std::vector<I>& elems, P p) {
    std::vector<unsigned> comp;
    if (inds.size() == 0) {
      return comp;
    }

    std::vector<unsigned> buf;
    buf.push_back(inds.back());
    inds.pop_back();

    while (buf.size() > 0) {
      auto next = buf.back();
      comp.push_back(next);
      buf.pop_back();

      std::vector<unsigned> inds_to_remove = p(inds, elems, buf, next);
	//	select_neighbors(inds, elems, buf, next, p);

      subtract(inds, inds_to_remove);
    }

    return comp;
  }

  template<typename I, typename P>
  std::vector<unsigned>
  dfs_by(std::vector<unsigned>& inds, const std::vector<I>& elems, P p) {
    auto neighbors = [p](std::vector<unsigned>& inds,
			 const std::vector<I>& elems,
			 std::vector<unsigned>& buf,
			 unsigned next) {
      return select_neighbors(inds, elems, buf, next, p);
    };

    return dfs_by_neighbors(inds, elems, neighbors);
  }

  template<typename I, typename P>
  std::vector<std::vector<unsigned>>
  connected_components_by(const std::vector<I>& elems, P p) {
    std::vector<std::vector<unsigned>> components;
    std::vector<unsigned> inds(elems.size());
    std::iota(begin(inds), end(inds), 0);

    while (inds.size() > 0) {
      components.push_back(dfs_by(inds, elems, p));
    }

    return components;
  }

  template<typename I, typename P>
  std::vector<std::vector<I>>
  connected_components_by_elems(const std::vector<I>& elems, P p) {
    auto ccs = connected_components_by(elems, p);
    std::vector<std::vector<I>> res;
    for (auto cc : ccs) {
      std::vector<I> cc_elems;
      for (auto i : cc) {
	cc_elems.push_back(elems[i]);
      }
      res.push_back(cc_elems);
    }
    return res;
  }

  template<typename I, typename F>
  std::vector<I>
  greedy_chain(const I& init, const std::vector<I>& elems, F f) {
    std::vector<I> chain;
    chain.push_back(init);
    if (elems.size() == 0) { return chain; }
    std::vector<unsigned> used;
    bool found_next = true;
    while (found_next) {
      found_next = false;
      for (unsigned i = 0; i < elems.size(); i++) {
	if (!elem(i, used) && f(elems[i], chain.back())) {
	  chain.push_back(elems[i]);
	  used.push_back(i);
	  found_next = true;
	}
      }
    }
    return chain;
  }


  template<typename I>
  std::vector<I>
  copy_not_indexes(const std::vector<I>& elems,
		   std::vector<unsigned>& inds) {
    std::sort(begin(inds), end(inds));
    std::vector<I> cp_elems;
    for (unsigned i = 0; i < elems.size(); i++) {
      if (!(std::binary_search(begin(inds), end(inds), i))) {
    	cp_elems.push_back(elems[i]);
      }
    }
    return cp_elems;
  }

  template<typename I>
  std::vector<I>
  select_indexes(const std::vector<I>& elems,
		 std::vector<unsigned>& inds) {
    std::sort(begin(inds), end(inds));
    std::vector<I> cp_elems;
    for (unsigned i = 0; i < elems.size(); i++) {
      if (std::binary_search(begin(inds), end(inds), i)) {
    	cp_elems.push_back(elems[i]);
      }
    }
    return cp_elems;
  }

  // Set Operations

  // Start intersection
  template<typename A>
  std::set<A>
  intersection(const std::set<A>& l, const std::set<A>& r) {
    std::set<A> it;
    set_intersection(std::begin(l), std::end(l),
		     std::begin(r), std::end(r),
		     std::inserter(it, std::end(it)));
    return it;
  }  

  template<typename A>
  std::deque<A>
  intersection(const std::deque<A>& l, const std::deque<A>& r) {
    std::deque<A> it;
    for (auto& e : l) {
      if (elem(e, r)) {
	it.push_back(e);
      }
    }
    return it;
  }  

  template<typename A>
  std::vector<A>
  intersection(const std::vector<A>& l, const std::vector<A>& r) {
    std::vector<A> it;
    for (auto& e : l) {
      if (elem(e, r)) {
	it.push_back(e);
      }
    }
    return it;
  }  
  
  template<typename A>
  std::unordered_set<A>
  intersection(const std::unordered_set<A>& l, const std::unordered_set<A>& r) {
    std::unordered_set<A> it;
    for (auto& e : l) {
      if (elem(e, r)) {
	it.insert(e);
      }
    }
    return it;
  }

  // End intersection

  // Start difference

  template<typename T>
  std::vector<T> difference(const std::vector<T>& a,
			    const std::vector<T>& b) {
    std::vector<T> diff = a;
    subtract(diff, b);

    return diff;
  }

  template<typename T>
  std::set<T> difference(const std::set<T>& a,
			 const std::set<T>& b) {
    std::set<T> diff;
    for (auto& e : a) {
      if (!elem(e, b)) {
	diff.insert(e);
      }
    }

    return diff;
  }

  template<typename T>
  std::unordered_set<T> difference(const std::unordered_set<T>& a,
				   const std::unordered_set<T>& b) {
    std::unordered_set<T> diff;
    for (auto& e : a) {
      if (!elem(e, b)) {
	diff.insert(e);
      }
    }

    return diff;
  }

  template<typename T>
  std::deque<T> difference(const std::deque<T>& a,
			   const std::deque<T>& b) {
    std::deque<T> diff;
    for (auto& e : a) {
      if (!elem(e, b)) {
	diff.push_back(e);
      }
    }

    return diff;
  }
  
  // End difference
  
  template<typename I>
  std::vector<I> concat_all(const std::vector<std::vector<I>>& vs) {
    std::vector<I> all_vs;
    for (auto v : vs) {
      concat(all_vs, v);
    }
    return all_vs;
  }

  template<typename I>
  std::vector<I> sort_unique(const std::vector<I>& elems) {
    auto elems_cp = elems;
    sort(begin(elems_cp), end(elems_cp));
    auto it = unique(begin(elems_cp), end(elems_cp));
    elems_cp.resize(std::distance(begin(elems_cp), it));
    return elems_cp;
  }

  template<typename A, typename B>
  void map_insert(std::map<A, std::vector<B>>& m, A a, B b) {
    if (m.find(a) == std::end(m)) {
      std::vector<B> bs{b};
      m[a] = bs;
    } else {
      auto elems = m[a];
      elems.push_back(b);
      m[a] = elems;
    }
  }

  template<typename A, typename B>
  B map_find(const A& a, const std::unordered_map<A, B>& m) {
    auto f = m.find(a);
    if (f == std::end(m)) {
      DBG_ASSERT(false);
    }

    return f->second;
  }

  template<typename A, typename B>
  B map_find(const A& a, const std::map<A, B>& m) {
    auto f = m.find(a);
    if (f == std::end(m)) {
      DBG_ASSERT(false);
    }

    return f->second;
  }
  
  template<typename A, typename B>
  void map_insert(std::unordered_map<A, std::vector<B>>& m, A a, B b) {
    if (m.find(a) == std::end(m)) {
      std::vector<B> bs{b};
      m[a] = bs;
    } else {
      auto elems = m[a];
      elems.push_back(b);
      m[a] = elems;
    }
  }
  
  // TODO: Make this more efficient
  template<typename T, typename F>
  std::vector<T>
  partial_order_maxima(const std::vector<T>& elems, F f) {
    std::vector<T> maxima;
    for (unsigned i = 0; i < elems.size(); i++) {
      auto e = elems[i];
      bool gt_all = true;
      for (unsigned j = 0; j < elems.size(); j++) {
	auto a = elems[j];
	if (i != j && !f(a, e)) {
	  gt_all = false;
	}
      }
      if (gt_all) {
	maxima.push_back(e);
      }
    }
    return maxima;
  }

  template<typename Elem, typename Orthogonal>
  Elem
  next_orthogonal_to_all(const std::vector<Elem>& to_check,
			 const std::vector<Elem>& to_return_from,
			 Orthogonal orthogonal) {
    assert(to_return_from.size() > 0);
      
    if (to_check.size() == 0) { return to_return_from.front(); }

    for (unsigned i = 0; i < to_return_from.size(); i++) {
      Elem q = to_return_from[i];
      if (all_of(begin(to_check), end(to_check),
		 [q, orthogonal](const Elem& r)
		 { return orthogonal(q, r); })) {
	return to_return_from[i];
      }
    }

    DBG_ASSERT(false);
  }
  
  // TODO: Move to utils/algorithm
  template<typename Elem, typename Orthogonal>
  std::vector<Elem>
  take_basis(const std::vector<Elem>& elems,
	     Orthogonal orthogonal,
	     const unsigned num_elems) {
    assert(elems.size() > num_elems);
    std::vector<Elem> basis;
    for (unsigned i = 0; i < num_elems; i++) {
      basis.push_back(next_orthogonal_to_all(basis, elems, orthogonal));
    }
    return basis;
  }

  template<typename T>
  std::vector<T*> ptrs(std::vector<T>& elems) {
    std::vector<T*> pointers;
    for (T& e : elems) {
      pointers.push_back(&e);
    }
    return pointers;
  }

  template<typename T>
  void reverse(T& t) {
    std::reverse(begin(t), end(t));
  }

  template<typename T, typename F>
  T min_e(const std::deque<T>& e, F f) {
    return *min_element(begin(e), end(e),
			[f](const T& l, const T& r) { return f(l) < f(r); });
  }

  template<typename T>
  T min_e(const std::deque<T>& e) {
    return *min_element(begin(e), end(e));
  }
  
  template<typename T, typename F>
  T min_e(const std::vector<T>& e, F f) {
    return *min_element(begin(e), end(e),
			[f](const T& l, const T& r) { return f(l) < f(r); });
  }

  template<typename T>
  T min_e(const std::vector<T>& e) {
    return *min_element(begin(e), end(e));
  }
  
  template<typename T, typename F>
  T min_e(const std::set<T>& e, F f) {
    return *min_element(begin(e), end(e),
			[f](const T& l, const T& r) { return f(l) < f(r); });
  }

  template<typename T>
  T min_e(const std::set<T>& e) {
    return *min_element(begin(e), end(e));
  }

  // template<typename T, unsigned long I>
  // T max_e(const std::array<T, I>& e) {
  //   return *max_element(e.begin(), e.end());
  // }
  
  template<typename T, typename F>
  T max_e(const std::vector<T>& e, F f) {
    return *max_element(begin(e), end(e),
			[f](const T& l, const T& r) { return f(l) < f(r); });
  }

  template<typename T>
  T max_e(const std::vector<T>& e) {
    return *max_element(begin(e), end(e));
  }

  template<typename T, typename F>
  T max_e(const std::deque<T>& e, F f) {
    return *max_element(begin(e), end(e),
			[f](const T& l, const T& r) { return f(l) < f(r); });
  }

  template<typename T>
  T max_e(const std::deque<T>& e) {
    return *max_element(begin(e), end(e));
  }

  template<typename T, typename F>
  T max_e(const std::set<T>& e, F f) {
    return *max_element(begin(e), end(e),
			[f](const T& l, const T& r) { return f(l) < f(r); });
  }

  template<typename T>
  T max_e(const std::set<T>& e) {
    return *max_element(begin(e), end(e));
  }
  
  template<typename T, typename F>
  T max_e(const std::unordered_set<T>& e, F f) {
    return *max_element(begin(e), end(e),
			[f](const T& l, const T& r) { return f(l) < f(r); });
  }

  template<typename T>
  T max_e(const std::unordered_set<T>& e) {
    return *max_element(begin(e), end(e));
  }

  template<typename T, typename F>
  T min_e(const std::unordered_set<T>& e, F f) {
    return *min_element(begin(e), end(e),
			[f](const T& l, const T& r) { return f(l) < f(r); });
  }

  template<typename T>
  T min_e(const std::unordered_set<T>& e) {
    return *min_element(begin(e), end(e));
  }

  template<typename T, typename F>
  T max_e(const std::list<T>& e, F f) {
    return *max_element(begin(e), end(e),
			[f](const T& l, const T& r) { return f(l) < f(r); });
  }

  template<typename T>
  T max_e(const std::list<T>& e) {
    return *max_element(begin(e), end(e));
  }

  template<typename T, typename F>
  T min_e(const std::list<T>& e, F f) {
    return *min_element(begin(e), end(e),
			[f](const T& l, const T& r) { return f(l) < f(r); });
  }

  template<typename T>
  T min_e(const std::list<T>& e) {
    return *min_element(begin(e), end(e));
  }

  template<typename T, typename F>
  T max_e(const std::forward_list<T>& e, F f) {
    return *max_element(begin(e), end(e),
			[f](const T& l, const T& r) { return f(l) < f(r); });
  }

  template<typename T>
  T max_e(const std::forward_list<T>& e) {
    return *max_element(begin(e), end(e));
  }

  template<typename T, typename F>
  T min_e(const std::forward_list<T>& e, F f) {
    return *min_element(begin(e), end(e),
			[f](const T& l, const T& r) { return f(l) < f(r); });
  }

  template<typename T>
  T min_e(const std::forward_list<T>& e) {
    return *min_element(begin(e), end(e));
  }

  template<typename T, typename F>
  void sort_lt(std::vector<T>& e, F f) {
    std::sort(begin(e), end(e), [f](const T& l, const T& r) { return f(l) < f(r); });
  }

  template<typename T, typename F>
  void sort_gt(std::vector<T>& e, F f) {
    std::sort(begin(e), end(e), [f](const T& l, const T& r) { return f(l) > f(r); });
  }

  template<typename A, typename B>
  bool contains_key(const A& a, const std::unordered_map<A, B>& m) {
    auto f = m.find(a);
    if (f == std::end(m)) {
      return false;
    }

    return true;
  }

  template<typename A, typename B>
  bool contains_key(const A& a, const std::map<A, B>& m) {
    auto f = m.find(a);
    if (f == std::end(m)) {
      return false;
    }

    return true;
  }

  template<typename T>
  bool elems_equal(const std::vector<T>& x,
		   const std::vector<T>& y) {
    if (x.size() != y.size()) { return false; }

    for (unsigned i = 0; i < x.size(); i++) {
      if (x[i] != y[i]) { return false; }
    }
    return true;
  }

  template<typename A, typename F>
  bool any_of(const A& container, F f) {
    return any_of(begin(container), end(container), f);
  }

  template<typename A, typename F>
  bool all_of(const A& container, F f) {
    return all_of(begin(container), end(container), f);
  }

  template<typename T, typename EqualityTest>
  bool elem_by(const T& e, const std::vector<T>& vals, EqualityTest eq) {

    for (auto& v : vals) {
      if (eq(e, v)) { return true; }
    }

    return false;
  }

  template<typename T>
  class maybe {

    T value;
    bool has_val;

  public:

    maybe(const T& value_) : value(value_), has_val(true) {}
    maybe() : has_val(false) {}
                                                         
    bool has_value() const { return has_val; }

    T get_value() const {
      assert(has_value());
      return value;
    }
  };

}

#endif
