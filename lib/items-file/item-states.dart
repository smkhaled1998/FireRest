
abstract class ItemsStates{}

class ItemsInitialState extends ItemsStates{}

class ItemsGettingDataLoadingState extends ItemsStates{}
class ItemsGettingDataSuccessState extends ItemsStates{}
class ItemsGettingDataErrorState extends ItemsStates{}



class ItemsPostingDataLoadingState extends ItemsStates{}
class ItemsPostingDataSuccessState extends ItemsStates{}
class ItemsPostingDataErrorState extends ItemsStates{}


class ItemsUpdatingDataLoadingState extends ItemsStates{}
class ItemsUpdatingDataSuccessState extends ItemsStates{}
class ItemsUpdatingDataErrorState extends ItemsStates{}

/// Img
class ItemsPickingImgLoadingState extends ItemsStates{}
class ItemsPickingImgSuccessState extends ItemsStates{}
class ItemsPickingImgErrorState extends ItemsStates{}

class ItemsUploadingImgLoadingState extends ItemsStates{}
class ItemsUploadingImgSuccessState extends ItemsStates{}
class ItemsUploadingImgErrorState extends ItemsStates{}

class ItemsDownLoadingImgUrlLoadingState extends ItemsStates{}
class ItemsDownLoadingImgUrlSuccessState extends ItemsStates{}
class ItemsDownLoadingImgUrlErrorState extends ItemsStates{}


/// Updated
class ItemsUploadingUpdatedImgLoadingState extends ItemsStates{}
class ItemsUploadingUpdatedImgSuccessState extends ItemsStates{}
class ItemsUploadingUpdatedImgErrorState extends ItemsStates{}

class ItemsDownLoadingUpdatedImgUrlLoadingState extends ItemsStates{}
class ItemsDownLoadingUpdatedImgUrlSuccessState extends ItemsStates{}
class ItemsDownLoadingUpdatedImgUrlErrorState extends ItemsStates{}

/// Delet

class ItemsDeleteDataLoadingState extends ItemsStates{}
class ItemsDeleteDataSuccessState extends ItemsStates{}
class ItemsDeleteDataErrorState extends ItemsStates{}