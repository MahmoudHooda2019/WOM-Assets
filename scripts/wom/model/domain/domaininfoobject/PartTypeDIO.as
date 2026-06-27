package wom.model.domain.domaininfoobject
{
   import wom.model.game.resource.ResourceType;
   
   public class PartTypeDIO
   {
      
      public static const LUMBER_GIFT:PartTypeDIO = new PartTypeDIO(101,"LumberTouchUp",0,0,ResourceType.LUMBER.id,null);
      
      public static const STONE_GIFT:PartTypeDIO = new PartTypeDIO(102,"StoneTouchUp",0,0,ResourceType.STONE.id,null);
      
      public static const IRON_GIFT:PartTypeDIO = new PartTypeDIO(103,"IronTouchUp",0,0,ResourceType.IRON.id,null);
      
      public static const MIGHT_GIFT:PartTypeDIO = new PartTypeDIO(104,"MightTouchUp",0,0,ResourceType.MIGHT.id,null);
      
      public static const gifts:Array = [LUMBER_GIFT,STONE_GIFT,IRON_GIFT,MIGHT_GIFT];
      
      private var _id:int;
      
      private var _visual:String;
      
      private var _buyingGoldPrice:int;
      
      private var _buyingRPPrice:int;
      
      private var _sellingResourceType:int;
      
      private var _usedInBuildingIds:Vector.<int>;
      
      public function PartTypeDIO(param1:int, param2:String, param3:int, param4:int, param5:int, param6:Vector.<int>)
      {
         super();
         _id = param1;
         _visual = param2;
         _buyingGoldPrice = param3;
         _buyingRPPrice = param4;
         _sellingResourceType = param5;
         _usedInBuildingIds = param6;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get visual() : String
      {
         return _visual;
      }
      
      public function get buyingGoldPrice() : int
      {
         return _buyingGoldPrice;
      }
      
      public function get buyingRPPrice() : int
      {
         return _buyingRPPrice;
      }
      
      public function get sellingResourceType() : int
      {
         return _sellingResourceType;
      }
      
      public function get usedInBuildingIds() : Vector.<int>
      {
         return _usedInBuildingIds;
      }
   }
}

