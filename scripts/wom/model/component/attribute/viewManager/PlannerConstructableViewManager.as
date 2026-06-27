package wom.model.component.attribute.viewManager
{
   import flash.geom.Matrix;
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.bounds.compositeBased.CompositeChildRenderBounds;
   import peak.cuckoo.game.attribute.bounds.compositeBased.CompositeRenderBounds;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import peak.cuckoo.game.dto.Point3;
   import peak.resource.atlas.starling.StarlingAtlasReference;
   import wom.model.component.WomPlannerRootV2;
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.attribute.projection.PlannerProjection;
   import wom.model.component.entity.gamesprite.PlannerBuilding;
   import wom.model.domain.domaininfoobject.ConstructableTypeDIO;
   import wom.model.resource.WomAssetRepository;
   
   public class PlannerConstructableViewManager extends Attribute
   {
      
      private var compositeView:CompositeView;
      
      private var ownerPlannerBuilding:PlannerBuilding;
      
      private var assetRepository:WomAssetRepository;
      
      private var ownerPosition:Position;
      
      private var rangeView:GameSprite;
      
      private var levelViewSprites:Vector.<GameSprite>;
      
      private var levelSuitable:Boolean;
      
      public var mainVisual:GameSprite;
      
      private var plannerIcon:GameSprite;
      
      private var squareColor:uint;
      
      private var _squareAssetId:String = "CityPlannerFloor";
      
      private var _rangeAssetId:String = "CityPlannerBuildingRange";
      
      protected var squareReference:StarlingAtlasReference;
      
      protected var constructableTypeDIO:ConstructableTypeDIO;
      
      protected var ownerBuildingRootData:BuildingData;
      
      private var selected:Boolean;
      
      private var collided:Boolean;
      
      public function PlannerConstructableViewManager(param1:GameSprite, param2:Boolean, param3:BuildingData = null)
      {
         super();
         param1.componentManager.add(param1.view = new CompositeView());
         compositeView = param1.view as CompositeView;
         param1.composite = param1;
         param1.componentManager.add(param1.bounds = new CompositeRenderBounds());
         this.levelSuitable = param2;
         this.ownerBuildingRootData = param3;
      }
      
      override public function init() : void
      {
         if(initialized)
         {
            return;
         }
         super.init();
         ownerPlannerBuilding = owner as PlannerBuilding;
         assetRepository = (owner.root as WomPlannerRootV2).assetRepository;
         ownerPosition = owner.componentManager["Position"] as Position;
         squareReference = owner.root.atlasManager.getAtlasReference(_squareAssetId);
         addMainVisual();
         levelViewSprites = new Vector.<GameSprite>();
         addLevel();
      }
      
      protected function addMainVisual() : void
      {
         var _loc2_:Number = NaN;
         mainVisual = new GameSprite();
         mainVisual.composite = ownerPlannerBuilding;
         mainVisual.componentManager.add(mainVisual.position = new Position(new Point3()));
         mainVisual.componentManager.add(mainVisual.view = new AssetView(3,_squareAssetId,true));
         mainVisual.componentManager.add(new PlannerProjection());
         mainVisual.componentManager.add(mainVisual.bounds = new CompositeChildRenderBounds());
         owner.addChild(mainVisual);
         mainVisual.init();
         compositeView.addChild(mainVisual);
         plannerIcon = new GameSprite();
         plannerIcon.composite = ownerPlannerBuilding;
         plannerIcon.componentManager.add(plannerIcon.position = new Position(new Point3(0,0,2)));
         plannerIcon.componentManager.add(plannerIcon.view = new AssetView(3,constructableTypeDIO.plannerIcon,true));
         plannerIcon.componentManager.add(new PlannerProjection());
         plannerIcon.componentManager.add(plannerIcon.bounds = new CompositeChildRenderBounds());
         owner.addChild(plannerIcon);
         plannerIcon.init();
         compositeView.addChild(plannerIcon);
         var _loc3_:StarlingAtlasReference = owner.root.atlasManager.getAtlasReference(constructableTypeDIO.plannerIcon);
         var _loc5_:int = constructableTypeDIO.baseSize * 3;
         var _loc1_:Number = _loc5_ / squareReference.width;
         if(constructableTypeDIO.baseSize <= 4)
         {
            _loc2_ = _loc3_ ? _loc5_ / _loc3_.width : 1;
         }
         else
         {
            _loc2_ = _loc1_ > 1 ? 1 : _loc1_;
         }
         var _loc4_:Matrix = new Matrix();
         var _loc7_:Number = (_loc5_ - squareReference.width) / 2;
         _loc4_.scale(_loc1_,_loc1_);
         _loc4_.translate(_loc7_,_loc7_);
         mainVisual.view.applyMatrix(_loc4_);
         mainVisual.view.colorFilter(squareColor = getSquareColor());
         _loc4_.identity();
         _loc4_.scale(_loc2_,_loc2_);
         var _loc6_:Number = _loc3_ ? _loc3_.width : 0;
         var _loc8_:Number = _loc3_ ? _loc3_.height : 0;
         _loc4_.translate((_loc5_ - _loc6_) / 2,(_loc5_ - _loc8_) / 2);
         plannerIcon.view.applyMatrix(_loc4_);
      }
      
      public function addRange() : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:StarlingAtlasReference = null;
         var _loc3_:int = 0;
         var _loc1_:Number = NaN;
         var _loc2_:Matrix = null;
         var _loc4_:Number = NaN;
         if(!rangeView)
         {
            rangeView = new GameSprite();
            rangeView.composite = ownerPlannerBuilding;
            _loc5_ = -ownerPlannerBuilding.data.range + ownerPlannerBuilding.data.halfBaseSize;
            rangeView.componentManager.add(rangeView.position = new Position(new Point3(_loc5_,_loc5_)));
            rangeView.componentManager.add(rangeView.view = new AssetView(4,_rangeAssetId,true));
            rangeView.componentManager.add(new PlannerProjection());
            rangeView.componentManager.add(rangeView.bounds = new CompositeChildRenderBounds());
            owner.addChild(rangeView);
            rangeView.init();
            owner.root.layers[4].add(rangeView);
            _loc6_ = owner.root.atlasManager.getAtlasReference(_rangeAssetId);
            _loc3_ = ownerPlannerBuilding.data.range * 3 * 2;
            _loc1_ = _loc3_ / _loc6_.width;
            _loc2_ = new Matrix();
            _loc4_ = (_loc3_ - _loc6_.width) / 2;
            _loc2_.scale(_loc1_,_loc1_);
            _loc2_.translate(_loc4_,_loc4_);
            rangeView.view.applyMatrix(_loc2_);
            updateView();
         }
      }
      
      public function removeRange() : void
      {
         if(rangeView)
         {
            owner.root.layers[4].remove(rangeView);
            owner.destroyChild(rangeView);
            rangeView = null;
            (owner as GameSprite).bounds.update();
         }
      }
      
      public function addLevel() : void
      {
         var _loc3_:int = 0;
         var _loc1_:String = null;
         var _loc4_:int = 0;
         var _loc2_:GameSprite = null;
         if(levelViewSprites.length == 0 && levelSuitable)
         {
            _loc3_ = 0;
            _loc1_ = "" + ownerPlannerBuilding.data.level;
            _loc4_ = 0;
            while(_loc4_ < _loc1_.length)
            {
               _loc2_ = new GameSprite();
               _loc2_.composite = ownerPlannerBuilding;
               _loc2_.componentManager.add(_loc2_.position = new Position(new Point3(_loc3_ / 3,0,10)));
               _loc2_.componentManager.add(_loc2_.view = new AssetView(3,"Number" + _loc1_.charAt(_loc4_),true));
               _loc2_.componentManager.add(new PlannerProjection());
               _loc2_.componentManager.add(_loc2_.bounds = new CompositeChildRenderBounds());
               owner.addChild(_loc2_);
               _loc2_.init();
               compositeView.addChild(_loc2_);
               levelViewSprites.push(_loc2_);
               _loc2_.view.scaleFixed(0.5);
               _loc3_ = _loc2_.bounds.width - 2;
               _loc4_++;
            }
         }
      }
      
      public function removeLevel() : void
      {
         var _loc1_:GameSprite = null;
         while(levelViewSprites.length > 0)
         {
            _loc1_ = levelViewSprites[0];
            compositeView.clearChild(_loc1_);
            owner.destroyChild(_loc1_);
            levelViewSprites.splice(0,1);
         }
      }
      
      public function setSelected(param1:Boolean) : void
      {
         this.selected = param1;
         updateView();
      }
      
      public function setCollision(param1:Boolean) : void
      {
         this.collided = param1;
         updateView();
      }
      
      private function updateView() : void
      {
         if(selected)
         {
            mainVisual.view.alphaFilter(0.5);
            plannerIcon.view.alphaFilter(0.5);
         }
         else
         {
            mainVisual.view.alphaFilter(1);
            plannerIcon.view.alphaFilter(1);
         }
         if(collided)
         {
            mainVisual.view.colorFilter(3355443);
         }
         else
         {
            mainVisual.view.colorFilter(squareColor);
         }
      }
      
      override public function destroy() : void
      {
         removeLevel();
         removeRange();
         super.destroy();
      }
      
      public function getSquareColor() : uint
      {
         var _loc1_:Boolean = false;
         if(!ownerBuildingRootData)
         {
            return 1;
         }
         if(ownerBuildingRootData.buildingInfo.buildingTypeId != 41)
         {
            if(ownerBuildingRootData.buildingInfo.buildingTypeId == 40)
            {
               _loc1_ = ownerBuildingRootData.buildingInfo.healthPoint == 0;
               return _loc1_ ? 8591616 : 16743936;
            }
            if(ownerBuildingRootData.buildingInfo.buildingTypeId == 39)
            {
               _loc1_ = ownerBuildingRootData.buildingInfo.healthPoint == 0;
               return _loc1_ ? 2440503 : 5864555;
            }
            return ownerBuildingRootData.buildingTypeDIO.kind.color;
         }
         switch(ownerBuildingRootData.buildingInfo.level - 1)
         {
            case 0:
               return 12939008;
            case 1:
               return 15381614;
            case 2:
               return 10979941;
            case 3:
               return 6971474;
            case 4:
               return 1520240;
            default:
               _loc1_ = ownerBuildingRootData.buildingInfo.healthPoint == 0;
               return _loc1_ ? 8591616 : 16743936;
         }
      }
   }
}

