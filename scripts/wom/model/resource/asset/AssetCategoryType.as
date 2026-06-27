package wom.model.resource.asset
{
   public class AssetCategoryType
   {
      
      public static const TUTORIAL_ALL:AssetCategoryType = new AssetCategoryType(0,null);
      
      public static const TUTORIAL_BUILD_MENU:AssetCategoryType = new AssetCategoryType(1,new <String>["B41BuildMenu","B31BuildMenu","B32BuildMenu","B39BuildMenu","B33BuildMenu","B34BuildMenu","B35BuildMenu","B36BuildMenu","B37BuildMenu","B40BuildMenu","B20BuildMenu","B19BuildMenu","B17BuildMenu","B18BuildMenu","B28BuildMenu","B23BuildMenu","B26BuildMenu","B27BuildMenu","B21BuildMenu","B29BuildMenu"]);
      
      public static const TUTORIAL_STORE_ITEM:AssetCategoryType = new AssetCategoryType(2,new <String>["ExtraWorker","FasterUpgrade","CityExpansion","FinishNow","Cut30Min","Cut1Hour","Cut2Hours"]);
      
      public static const TUTORIAL_BUILDING_SILHOUETTE:AssetCategoryType = new AssetCategoryType(3,new <String>["B31Silhouette","B20S1Silhouette","B11S2Silhouette"]);
      
      public static const TUTORIAL_BUILDING_CANVAS:AssetCategoryType = new AssetCategoryType(4,new <String>["B22S1Building","B31Building","B19BuildingBack","B19BuildingFront","B20S1Building","B10S1Building","B11S1Building","B12S1Building","B13S1Building","B14S1Building","B15Building"]);
      
      public static const TUTORIAL_QUEST_ICONS:AssetCategoryType = new AssetCategoryType(5,new <String>["Q40"]);
      
      public static const TUTORIAL_MERC_SMALL_AVATAR:AssetCategoryType = new AssetCategoryType(6,new <String>["BedoinBruteSmall","JanissarySmall","NightRiderSmall","PersianHashishinSmall","KhamikazeeSmall","NubianGuardSmall","RavagerSmall","PainblowerSmall","SneakPeakSmall","MongolianGargantuanSmall","PharaohWarriorSmall","GentleHealerSmall","PersianSapperSmall","HezarfenSmall","RocknGaulSmall"]);
      
      public static const TUTORIAL_MERC_MEDIUM_AVATAR:AssetCategoryType = new AssetCategoryType(7,new <String>["BedoinBruteMedium"]);
      
      public static const TUTORIAL_INVITE_IMAGE:AssetCategoryType = new AssetCategoryType(8,new <String>["InviteFriendsImage"]);
      
      private var _id:int;
      
      private var _assets:Vector.<String>;
      
      public function AssetCategoryType(param1:int, param2:Vector.<String>)
      {
         super();
         _id = param1;
         _assets = param2;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get assets() : Vector.<String>
      {
         return _assets;
      }
   }
}

