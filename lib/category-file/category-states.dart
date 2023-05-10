
abstract class CategoryStates{}

class CategoryInitialState extends CategoryStates{}
class CategoryInitiatePageViewState extends CategoryStates{}
class CategoryChangeBottomNavBarState extends CategoryStates{}


///getting data

class CategoryGettingDataLoadingState extends CategoryStates{}
class CategoryGettingDataSuccessState extends CategoryStates{}
class CategoryGettingDataErrorState extends CategoryStates{}

class CategoryPostingDataLoadingState extends CategoryStates{}
class CategoryPostingDataSuccessState extends CategoryStates{}
class CategoryPostingDataErrorState extends CategoryStates{}


class CategoryUpdatingDataLoadingState extends CategoryStates{}
class CategoryUpdatingDataSuccessState extends CategoryStates{}
class CategoryUpdatingDataErrorState extends CategoryStates{}

/// Img
class CategoryPickingImgLoadingState extends CategoryStates{}
class CategoryPickingImgSuccessState extends CategoryStates{}
class CategoryPickingImgErrorState extends CategoryStates{}

class CategoryUploadingImgLoadingState extends CategoryStates{}
class CategoryUploadingImgSuccessState extends CategoryStates{}
class CategoryUploadingImgErrorState extends CategoryStates{}

class CategoryDownLoadingImgUrlLoadingState extends CategoryStates{}
class CategoryDownLoadingImgUrlSuccessState extends CategoryStates{}
class CategoryDownLoadingImgUrlErrorState extends CategoryStates{}


/// Updated
class CategoryUploadingUpdatedImgLoadingState extends CategoryStates{}
class CategoryUploadingUpdatedImgSuccessState extends CategoryStates{}
class CategoryUploadingUpdatedImgErrorState extends CategoryStates{}

class CategoryDownLoadingUpdatedImgUrlLoadingState extends CategoryStates{}
class CategoryDownLoadingUpdatedImgUrlSuccessState extends CategoryStates{}
class CategoryDownLoadingUpdatedImgUrlErrorState extends CategoryStates{}

/// Delet

class CategoryDeleteDataLoadingState extends CategoryStates{}
class CategoryDeleteDataSuccessState extends CategoryStates{}
class CategoryDeleteDataErrorState extends CategoryStates{}