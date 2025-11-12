sealed class SearchState{}

class SearchInitialState extends SearchState{}

class ClearSearchTextState extends SearchState{}

class ShowSearchFilterState extends SearchState{}

class ClearFiltersState extends SearchState{}

class LoadingGetSearchProductState extends SearchState{}

class SuccessGetSearchProductState extends SearchState{}

class ErrorGetSearchProductState extends SearchState{}

class PriceErrorState extends SearchState{}

class ChangeActiveFiltersState extends SearchState{}

class SortProductsByPriceDescendingState extends SearchState{}

class SortProductsByPriceAscendingState extends SearchState{}
