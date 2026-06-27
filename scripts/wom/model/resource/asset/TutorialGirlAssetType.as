package wom.model.resource.asset
{
   public class TutorialGirlAssetType
   {
      
      public static const POSE1:TutorialGirlAssetType = new TutorialGirlAssetType(1);
      
      public static const POSE2:TutorialGirlAssetType = new TutorialGirlAssetType(2);
      
      public static const POSE3:TutorialGirlAssetType = new TutorialGirlAssetType(3);
      
      public static const POSE6:TutorialGirlAssetType = new TutorialGirlAssetType(6);
      
      public static const POSE7:TutorialGirlAssetType = new TutorialGirlAssetType(7);
      
      public static const POSE8:TutorialGirlAssetType = new TutorialGirlAssetType(8);
      
      private var _id:int;
      
      public function TutorialGirlAssetType(param1:int)
      {
         super();
         _id = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
   }
}

