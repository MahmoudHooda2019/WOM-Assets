package wom.model.component.behavior
{
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.projection.IsoProjection;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.resource.atlas.starling.StarlingAtlasReference;
   import wom.model.component.WomGameRoot;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   
   public class BuildingRangeManager extends Behavior
   {
      
      public static const TYPE_ID:String = "BuildingRangeManager";
      
      private var targetRange:Number;
      
      private var targetRangeFactor:Number;
      
      private var targetRangeFactorEnlarged:Number;
      
      private var range:Number = 0;
      
      private var buildingRangeView:AssetView;
      
      private var state:int;
      
      private const INFLATE_GROW:int = 1;
      
      private const INFLATE_BOUNCE:int = 2;
      
      private const DEFLATE_BOUNCE:int = 4;
      
      private const DEFLATE:int = 3;
      
      private const ENLARGE_RATIO:Number = 1.1;
      
      public function BuildingRangeManager(param1:Number = -1)
      {
         super();
         this.targetRange = param1;
         priority = 0;
      }
      
      override public function get typeId() : String
      {
         return "BuildingRangeManager";
      }
      
      override public function init() : void
      {
         var _loc1_:Building = null;
         var _loc3_:int = 0;
         super.init();
         var _loc2_:WomGameRoot = owner.root as WomGameRoot;
         var _loc4_:StarlingAtlasReference = _loc2_.atlasManager.getAtlasReference("TowerRange");
         if(owner.parent is Building)
         {
            _loc1_ = owner.parent as Building;
            _loc3_ = _loc1_.data.buildingInfo.level == 0 ? 0 : _loc1_.data.buildingInfo.level - 1;
            targetRange = _loc1_.data.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.RANGES_PER_LEVEL_IN_PX.id][_loc3_] * 0.2;
         }
         targetRange = targetRange * (_loc2_.projection as IsoProjection).pitchX * Math.sqrt(2);
         targetRangeFactor = targetRange / _loc4_.width;
         buildingRangeView = (owner as GameSprite).view as AssetView;
         targetRangeFactorEnlarged = targetRangeFactor * 1.1;
         state = 1;
      }
      
      override public function update() : void
      {
         var _loc1_:Number = NaN;
         if(state == 1)
         {
            _loc1_ = (targetRangeFactorEnlarged - range) / 5;
            range += _loc1_;
            buildingRangeView.scaleFixed(range);
            buildingRangeView.alphaFilter(range / targetRangeFactorEnlarged);
            if(_loc1_ <= 0.01)
            {
               state = 2;
            }
         }
         else if(state == 2)
         {
            range -= 0.04;
            if(range <= targetRangeFactor)
            {
               buildingRangeView.scaleFixed(range = targetRangeFactor);
               disable();
            }
            else
            {
               buildingRangeView.scaleFixed(range);
            }
         }
         else if(state == 4)
         {
            range += 0.04;
            buildingRangeView.scaleFixed(range);
            if(range >= targetRangeFactor)
            {
               state = 3;
            }
         }
         else if(state == 3)
         {
            _loc1_ = range / 5;
            range -= _loc1_;
            buildingRangeView.scaleFixed(range);
            buildingRangeView.alphaFilter(range / targetRangeFactorEnlarged);
            if(range <= 0.01)
            {
               destroy();
            }
         }
      }
      
      public function remove(param1:Boolean = false) : void
      {
         if(param1)
         {
            destroy();
         }
         else
         {
            state = 4;
            targetRangeFactor = range * 1.2;
            enable();
         }
      }
      
      override public function destroy() : void
      {
         if(owner.parent is Building)
         {
            (owner.parent as Building).viewManager.clearRangeView();
         }
         super.destroy();
      }
      
      public function reAnimate() : void
      {
         if(state > 2)
         {
            init();
            enable();
         }
      }
   }
}

