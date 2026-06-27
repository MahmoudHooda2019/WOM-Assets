package wom.model.domain.domaininfoobject
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import wom.model.game.building.BuildMenuCategory;
   import wom.model.game.building.BuildMenuDecorationCategory;
   import wom.model.game.building.DecorationVariationInfo;
   
   public class DecorationTypeDIO extends ConstructableTypeDIO
   {
      
      public static const FLAG_ID:int = 114;
      
      public static const ALLIANCE_FLAG_ID:int = 115;
      
      public static const EMPTY_ALLIANCE_FLAG:String = "16777215x16777215x0";
      
      public var buildMenuDecorationCategory:BuildMenuDecorationCategory;
      
      public var decorationKinds:Vector.<String>;
      
      public var visual:String;
      
      public var buyPrice:int;
      
      public var sellPrice:int;
      
      public var buyWithGold:Boolean;
      
      public var offset:Point;
      
      public function DecorationTypeDIO(param1:int, param2:ConstructableKindTypeDIO, param3:int, param4:BuildMenuDecorationCategory, param5:Vector.<String>, param6:String, param7:int, param8:int, param9:Boolean, param10:Point, param11:String, param12:Point)
      {
         super(param1,param2,param3,BuildMenuCategory.DECORATORS,param11,new Dictionary(),param12);
         this.buildMenuDecorationCategory = param4;
         this.decorationKinds = param5;
         this.visual = param6;
         this.buyPrice = param7;
         this.sellPrice = param8;
         this.buyWithGold = param9;
         this.offset = param10;
      }
      
      public function getVariations() : Vector.<DecorationVariationInfo>
      {
         var _loc2_:Vector.<DecorationVariationInfo> = new Vector.<DecorationVariationInfo>();
         if(decorationKinds == null)
         {
            _loc2_.push(new DecorationVariationInfo(this,null));
         }
         else
         {
            for each(var _loc1_ in decorationKinds)
            {
               _loc2_.push(new DecorationVariationInfo(this,_loc1_));
            }
         }
         return _loc2_;
      }
   }
}

