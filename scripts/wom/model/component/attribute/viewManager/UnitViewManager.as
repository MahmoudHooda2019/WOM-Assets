package wom.model.component.attribute.viewManager
{
   import flash.geom.Point;
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.bounds.notCompositeBased.ChildRenderBounds;
   import peak.cuckoo.game.attribute.filter.FilterManager;
   import peak.cuckoo.game.attribute.projection.BaseProjection;
   import peak.cuckoo.game.attribute.projection.HeightRevertedProjection;
   import peak.cuckoo.game.attribute.view.AnimationAssetView;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.behavior.animation.StateDirectionAnimation;
   import peak.cuckoo.game.dto.Point3;
   import peak.resource.AssetRepository;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.projection.UnitOffsetProjection;
   import wom.model.component.attribute.view.UnitSpeechBubbleView;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.domain.domaininfoobject.GenericUnitTypeDIO;
   import wom.model.domain.domaininfoobject.WorkerTypeDIO;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitTypeInfo;
   
   public class UnitViewManager extends Attribute
   {
      
      public static const STATE_COUNT:int = 8;
      
      public static const DIRECTION_COUNT:int = 8;
      
      public static const UNIT_HEALTH_PROGRESS_SLICE_COUNT:uint = 15;
      
      public static const TYPE_ID:String = "UnitViewManager";
      
      public static const NORMAL:int = 1;
      
      public static const INJURED:int = 2;
      
      public static const DEAD:int = 3;
      
      public static const ZINDEX_MAIN_VISUAL:int = 0;
      
      public static const ZINDEX_MAIN_VISUAL_FRONT:int = 50;
      
      public static const ZINDEX_PROGRESS_BAR:int = 70;
      
      private var unitInfo:UnitInfo;
      
      private var unitTypeInfo:UnitTypeInfo;
      
      private var unitTypeDIO:GenericUnitTypeDIO;
      
      private var workerInfo:WorkerTypeDIO;
      
      private var gameRootHolder:WomGameRootHolder;
      
      public var speechBubble:GameSprite;
      
      public var healthProgressBar:GameSprite;
      
      public var shadow:GameSprite;
      
      private var lastSpeechBubbleId:int;
      
      private var ownerPosition:Position;
      
      private var ownerUnit:Unit;
      
      private var assetRepository:AssetRepository;
      
      private var lastHealthProgressIndex:int = -1;
      
      public var view:AnimationAssetView;
      
      private var worker:Boolean = false;
      
      public var shadowOffset:Number;
      
      public var animationSortPoint:Point;
      
      private var layers:Array;
      
      public var middlePoint:Point;
      
      private var filterManager:FilterManager;
      
      public function UnitViewManager(param1:GameSprite, param2:UnitInfo, param3:UnitTypeInfo, param4:GenericUnitTypeDIO, param5:WorkerTypeDIO, param6:WomGameRootHolder)
      {
         super();
         this.unitInfo = param2;
         this.unitTypeInfo = param3;
         this.unitTypeDIO = param4;
         this.workerInfo = param5;
         this.gameRootHolder = param6;
      }
      
      override public function get typeId() : String
      {
         return "UnitViewManager";
      }
      
      override public function init() : void
      {
         if(initialized)
         {
            if(view.prepared)
            {
               mainAssetLoaded();
            }
            return;
         }
         super.init();
         layers = owner.root.layers;
         assetRepository = (owner.root as WomGameRoot).assetRepository;
         ownerUnit = owner as Unit;
         filterManager = ownerUnit.filterManager;
         ownerPosition = owner.componentManager["Position"] as Position;
         if(ownerUnit.data.typeDIO)
         {
            if(ownerUnit.data.typeDIO)
            {
               animationSortPoint = ownerUnit.isBeast ? (ownerUnit.data.typeDIO as BeastTypeDIO).animationSortPointsPerStage[ownerUnit.data.levelIndex] : ownerUnit.data.typeDIO.animationSortPoint;
            }
            else
            {
               animationSortPoint = new Point(32,46);
            }
            middlePoint = ownerUnit.isBeast ? new Point(64,64) : new Point(32,32);
         }
         manageAll();
      }
      
      override public function enable() : void
      {
         super.enable();
         (owner as GameSprite).view.init();
      }
      
      public function manageAll() : void
      {
         clearAll();
         manageMainVisuals();
      }
      
      private function manageMainVisuals() : void
      {
         var _loc1_:StateDirectionAnimation = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:String = null;
         if(workerInfo)
         {
            worker = true;
            _loc4_ = workerInfo.movementAnimationSpeed;
            _loc6_ = workerInfo.workAnimationSpeed;
            _loc7_ = 8;
            _loc3_ = 8;
            _loc1_ = new gameRootHolder.gameRoot.render.renderSpecificDirectionStateAnimation([{
               "start":4,
               "length":1,
               "fpsChangeRate":0
            },{
               "start":0,
               "length":4,
               "fpsChangeRate":_loc4_
            },{
               "start":4,
               "length":4,
               "fpsChangeRate":_loc6_
            }],_loc7_,_loc3_);
            owner.componentManager.add(ownerUnit.animation = _loc1_);
            owner.componentManager.add(ownerUnit.view = new AnimationAssetView(workerInfo.assetName,3));
            view = ownerUnit.view as AnimationAssetView;
            _loc1_.init();
            view.init();
         }
         else
         {
            _loc5_ = unitInfo.typeId;
            _loc4_ = unitTypeDIO.movementAnimationSpeed;
            _loc6_ = unitTypeDIO.attackAnimationSpeed;
            if(unitInfo.typeId == 29 || unitInfo.typeId == 34)
            {
               _loc7_ = 1;
               _loc3_ = 1;
               _loc1_ = new gameRootHolder.gameRoot.render.renderSpecificDirectionStateAnimation([{
                  "start":0,
                  "length":1,
                  "fpsChangeRate":1000
               }],_loc7_,_loc3_);
            }
            else
            {
               _loc7_ = 8;
               _loc3_ = 8;
               _loc1_ = new gameRootHolder.gameRoot.render.renderSpecificDirectionStateAnimation([{
                  "start":(unitTypeDIO.flying ? 0 : 4),
                  "length":(unitTypeDIO.flying ? 4 : 1),
                  "fpsChangeRate":(unitTypeDIO.flying ? _loc4_ : 0)
               },{
                  "start":0,
                  "length":4,
                  "fpsChangeRate":_loc4_
               },{
                  "start":4,
                  "length":4,
                  "fpsChangeRate":_loc6_
               }],_loc7_,_loc3_);
            }
            owner.componentManager.add((owner as Unit).animation = _loc1_);
            _loc2_ = "U" + _loc5_ + "Motion" + (ownerUnit.data.isBeast ? "S" + (ownerUnit.data.levelIndex + 1) + "Motion" : "");
            owner.componentManager.add(ownerUnit.view = new AnimationAssetView(_loc2_,3));
            view = ownerUnit.view as AnimationAssetView;
            view.assetLoaded.addFunctionOnce(mainAssetLoaded);
            filterManager.applyFilters();
            _loc1_.init();
            view.init();
         }
      }
      
      public function mainAssetLoaded() : void
      {
         manageShadow();
         manageHealthProgressBar();
      }
      
      private function manageShadow() : void
      {
         var _loc1_:String = null;
         if(unitTypeDIO.flying && (!shadow || !shadow.parent))
         {
            animationSortPoint = ownerUnit.isBeast ? (ownerUnit.data.typeDIO as BeastTypeDIO).animationSortPointsPerStage[ownerUnit.data.levelIndex] : ownerUnit.data.typeDIO.animationSortPoint;
            shadowOffset = 0;
            shadow = new GameSprite();
            _loc1_ = "";
            if(unitTypeDIO.id == 25)
            {
               _loc1_ = "DragonflyShadow";
               shadowOffset = 49;
            }
            else
            {
               _loc1_ = "HezarfenShadow";
               shadowOffset = 18;
            }
            shadow.componentManager.add(shadow.view = new AssetView(2,_loc1_,false));
            shadow.componentManager.add(shadow.position = new Position(new Point3(animationSortPoint.x - shadowOffset,-animationSortPoint.y,0)));
            shadow.componentManager.add(new HeightRevertedProjection());
            shadow.componentManager.add(shadow.bounds = new ChildRenderBounds());
         }
         if(shadow && !shadow.parent)
         {
            if("Wander" in ownerUnit.componentManager)
            {
               (ownerUnit.componentManager["BaseProjection"] as UnitOffsetProjection).addShadowInCBCM();
            }
            else
            {
               shadow.composite = ownerUnit;
               owner.addChild(shadow);
               shadow.init();
               (layers[2] as Layer).add(shadow);
               ownerUnit.position.init();
               (owner.componentManager["BaseProjection"] as BaseProjection).init();
               ownerUnit.position.refreshPosition();
            }
         }
      }
      
      public function manageHealthProgressBar() : void
      {
         var _loc2_:String = null;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         if(worker)
         {
            return;
         }
         var _loc9_:WorkerThread = ownerUnit.data.maxHealthPoint;
         var _loc6_:Number = _loc9_._value;
         var _loc8_:Number = ownerUnit.data.info.healthPoints;
         var _loc7_:Number = (1 - _loc8_ / _loc6_) * 15;
         var _loc4_:int = _loc7_ + 0.5;
         if(_loc8_ > 0 && _loc8_ < _loc6_)
         {
            if(_loc4_ != lastHealthProgressIndex || !healthProgressBar)
            {
               lastHealthProgressIndex = _loc4_;
               _loc2_ = "UnitHealth-" + _loc4_;
               if(healthProgressBar && healthProgressBar)
               {
                  (healthProgressBar.view as AssetView).changeAsset(_loc2_);
               }
               else if(view.prepared)
               {
                  healthProgressBar = new GameSprite();
                  _loc1_ = 27;
                  _loc5_ = animationSortPoint.x - _loc1_ / 2;
                  _loc3_ = -(ownerUnit.bounds.height >> 3);
                  healthProgressBar.componentManager.add(healthProgressBar.view = new AssetView(4,_loc2_));
                  healthProgressBar.componentManager.add(healthProgressBar.position = new Position(new Point3(_loc5_,_loc3_,70)));
                  healthProgressBar.componentManager.add(new HeightRevertedProjection());
                  healthProgressBar.componentManager.add(healthProgressBar.bounds = new ChildRenderBounds());
                  healthProgressBar.composite = ownerUnit;
                  if("Wander" in ownerUnit.componentManager)
                  {
                     (ownerUnit.componentManager["BaseProjection"] as UnitOffsetProjection).addHealthBarInCBCM();
                  }
                  else
                  {
                     owner.addChild(healthProgressBar);
                     healthProgressBar.init();
                     (layers[4] as Layer).add(healthProgressBar);
                     ownerUnit.position.refreshPosition();
                  }
               }
            }
         }
         else
         {
            lastHealthProgressIndex = _loc4_;
            clearHealthProgressBar();
         }
      }
      
      public function clearHealthProgressBar() : void
      {
         if(healthProgressBar)
         {
            if("Wander" in ownerUnit.componentManager)
            {
               (ownerUnit.componentManager["BaseProjection"] as UnitOffsetProjection).clearHealthbar();
            }
            else
            {
               (layers[4] as Layer).remove(healthProgressBar);
               healthProgressBar.parent && healthProgressBar.parent.destroyChild(healthProgressBar);
               owner.destroyChild(healthProgressBar);
               healthProgressBar = null;
            }
            lastHealthProgressIndex = -1;
         }
      }
      
      public function clearShadow() : void
      {
         if(shadow)
         {
            if("Wander" in ownerUnit.componentManager)
            {
               (ownerUnit.componentManager["BaseProjection"] as UnitOffsetProjection).clearShadow();
            }
            else
            {
               (layers[2] as Layer).remove(shadow);
               shadow.parent && shadow.parent.destroyChild(shadow);
               shadow = null;
            }
         }
      }
      
      public function drawSpeechBubble(param1:int, param2:int) : void
      {
         var _loc3_:int = param1 * 100 + param2;
         if(speechBubble && lastSpeechBubbleId == _loc3_)
         {
            return;
         }
         clearSpeechBubble();
         lastSpeechBubbleId = _loc3_;
         var _loc6_:UnitSpeechBubbleView = new UnitSpeechBubbleView(param1,param2);
         speechBubble = new GameSprite();
         var _loc5_:int = ownerUnit.bounds.width >> 1;
         var _loc4_:int = -(ownerUnit.bounds.height >> 3);
         speechBubble.componentManager.add(speechBubble.view = _loc6_);
         speechBubble.componentManager.add(speechBubble.position = new Position(new Point3(_loc5_,_loc4_,70)));
         speechBubble.componentManager.add(new HeightRevertedProjection());
         speechBubble.componentManager.add(speechBubble.bounds = new ChildRenderBounds());
         speechBubble.composite = ownerUnit;
         if(!("Wander" in ownerUnit.componentManager))
         {
            owner.addChild(speechBubble);
            speechBubble.init();
            (layers[4] as Layer).add(speechBubble);
            ownerUnit.position.refreshPosition();
         }
      }
      
      public function clearSpeechBubble() : void
      {
         if(speechBubble)
         {
            if(!("Wander" in ownerUnit.componentManager))
            {
               (layers[4] as Layer).remove(speechBubble);
               speechBubble.parent && speechBubble.parent.destroyChild(speechBubble);
               owner.destroyChild(speechBubble);
               speechBubble = null;
            }
            lastSpeechBubbleId = -1;
         }
      }
      
      override public function destroy() : void
      {
         clearAll();
         super.destroy();
      }
      
      override public function disable() : void
      {
         clearAll();
         super.disable();
      }
      
      private function clearAll() : void
      {
         clearHealthProgressBar();
         clearShadow();
         clearSpeechBubble();
      }
   }
}

