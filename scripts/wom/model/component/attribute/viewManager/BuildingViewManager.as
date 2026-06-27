package wom.model.component.attribute.viewManager
{
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.bounds.compositeBased.CompositeChildRenderBounds;
   import peak.cuckoo.game.attribute.bounds.compositeBased.CompositeRenderBounds;
   import peak.cuckoo.game.attribute.projection.IsoProjection;
   import peak.cuckoo.game.attribute.view.AnimationAssetView;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.attribute.view.BaseView;
   import peak.cuckoo.game.attribute.view.ColoredAssetView;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import peak.cuckoo.game.behavior.animation.ActionAnimation;
   import peak.cuckoo.game.behavior.animation.Animation;
   import peak.cuckoo.game.dto.Point3;
   import peak.resource.AssetRepository;
   import peak.resource.asset.core.BitmapAssetReference;
   import peak.resource.atlas.starling.StarlingAtlasReference;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.*;
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.attribute.projection.BuildingPartProjection;
   import wom.model.component.attribute.projection.HeightRevertedBuildingPartProjectionDeprecated;
   import wom.model.component.attribute.projection.IsoBuildingProjection;
   import wom.model.component.behavior.BounceEffect;
   import wom.model.component.behavior.BuildingRangeManager;
   import wom.model.component.behavior.TowerAnimationManager;
   import wom.model.component.behavior.building.BuildingUpgrade;
   import wom.model.component.behavior.building.UnitRecruit;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.building.BuildingTypeVisual;
   import wom.model.game.building.FortificationType;
   import wom.model.game.building.ScaffoldType;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.UnitRecruitJob;
   
   public class BuildingViewManager extends Attribute
   {
      
      public static const TYPE_ID:String = "BuildingViewManager";
      
      public static const NORMAL:int = 1;
      
      public static const DAMAGED:int = 2;
      
      public static const DESTROYED:int = 3;
      
      public static const ANIMATION_VISUAL_TYPE:String = "Animation";
      
      private static const HEALTH_PROGRESS_SLICE_COUNT:int = 30;
      
      public static const UPGRADE_PROGRESS_SLICE_COUNT:uint = 10;
      
      public static const RECRUIT_PROGRESS_SLICE_COUNT:uint = 10;
      
      public static const HEALTH_BARRIER_1:Number = 0.7;
      
      public static const HEALTH_BARRIER_2:Number = 0.5;
      
      public static const HEALTH_BARRIER_3:Number = 0.3;
      
      private static const NoAllianceCOAId:String = "16777215x16777215x1";
      
      public static const ZINDEX_FORTIFICATION_BACK:int = -19;
      
      public static const ZINDEX_SCAFFOLD_BACK:int = -15;
      
      public static const ZINDEX_BUILDING_RANGE:int = -12;
      
      public static const ZINDEX_BUILDING_FLOOR:int = -12;
      
      public static const ZINDEX_SOILS:int = -11;
      
      public static const ZINDEX_MAIN_VISUAL:int = 0;
      
      public static const ZINDEX_MAIN_VISUAL_FRONT:int = 50;
      
      public static const ZINDEX_SCAFFOLD_FRONT:int = 60;
      
      public static const ZINDEX_FORTIFICATION_FRONT:int = 61;
      
      public static const ZINDEX_SMOKE:int = 65;
      
      public static const ZINDEX_PROGRESS_BAR:int = 70;
      
      public static const ZINDEX_INDICATOR:int = 71;
      
      private var notLoop:Boolean;
      
      private var haveSoil:Boolean;
      
      private var removeAnimationIfDisabled:Boolean;
      
      private var womGameRoot:WomGameRoot;
      
      private var viewMap:Array;
      
      private var lastLevel:int = -1;
      
      private var lastState:int = -1;
      
      private var lastMouseFollowIncludedState:Boolean = false;
      
      private var lastHealthProgressIndex:int = -1;
      
      private var lastUpgradeProgressIndex:int = -1;
      
      private var lastRecruitProgressIndex:int = -1;
      
      private var lastFloorEnabledState:Boolean = false;
      
      private var lastScaffoldEnabledState:Boolean = false;
      
      private var lastFortificationLevel:int = 0;
      
      public var animation:Animation;
      
      public var specializedAnimation:Boolean = false;
      
      public var mainVisual:AssetView;
      
      private var mainVisuals:Vector.<GameSprite>;
      
      private var soilAsset:GameSprite;
      
      public var upgradeProgressBar:GameSprite;
      
      private var recruitProgressBar:GameSprite;
      
      private var healthProgressBar:GameSprite;
      
      private var buildingFloor:GameSprite;
      
      private var scaffoldFront:GameSprite;
      
      private var scaffoldBack:GameSprite;
      
      private var fortificationFront:GameSprite;
      
      private var fortificationBack:GameSprite;
      
      private var soil:GameSprite;
      
      private var indicator:GameSprite;
      
      private var rangeView:GameSprite;
      
      private var smokes:Vector.<GameSprite> = new Vector.<GameSprite>();
      
      private var mobileMoveArrows:Vector.<GameSprite> = new Vector.<GameSprite>();
      
      private var mobileTutorialArrow:GameSprite = null;
      
      private var initialFrameNumPercentage:Number = 0;
      
      private var lastAllianceCOAId:String = null;
      
      private var ownerPosition:Position;
      
      private var ownerBuildingData:BuildingData;
      
      private var assetRepository:AssetRepository;
      
      private var rootProjection:IsoProjection;
      
      private var ownerSprite:GameSprite;
      
      private var baseSize:int;
      
      private var sfx:SfxManager;
      
      public var compositeView:CompositeView;
      
      private var totalNewStateChangeAssetNumber:int;
      
      private var loadedNewStateChangeAssetNumber:int;
      
      private var lastStateBuildingVisualArray:Array = [];
      
      private var currentIndicator:String = null;
      
      public function BuildingViewManager(param1:GameSprite, param2:BuildingTypeDIO)
      {
         super();
         this.viewMap = param2.visualMap;
         this.notLoop = param2.animationNotLoop;
         this.haveSoil = param2.haveSoil;
         param1.componentManager.add(param1.view = new CompositeView());
         compositeView = param1.view as CompositeView;
         param1.componentManager.add(param1.bounds = new CompositeRenderBounds());
         mainVisuals = new Vector.<GameSprite>();
      }
      
      override public function get typeId() : String
      {
         return "BuildingViewManager";
      }
      
      override public function init() : void
      {
         if(initialized)
         {
            return;
         }
         super.init();
         womGameRoot = owner.root as WomGameRoot;
         ownerSprite = owner as GameSprite;
         assetRepository = womGameRoot.assetRepository;
         rootProjection = womGameRoot.projection as IsoProjection;
         ownerBuildingData = (owner as Building).data;
         baseSize = ownerBuildingData.buildingTypeDIO.baseSize;
         ownerPosition = owner.componentManager["Position"] as Position;
         sfx = womGameRoot.sfxManager;
         removeAnimationIfDisabled = ownerBuildingData.buildingTypeDIO.id == 20 || ownerBuildingData.buildingTypeDIO.id == 44;
         specializedAnimation = ownerBuildingData.buildingTypeDIO.kind.id == 11 || ownerBuildingData.buildingTypeDIO.id == 17 || ownerBuildingData.buildingTypeDIO.id == 18 || ownerBuildingData.buildingTypeDIO.id == 20 || ownerBuildingData.buildingTypeDIO.id == 21;
         manageAll();
      }
      
      override public function enable() : void
      {
         super.enable();
         ownerSprite.view.init();
      }
      
      public function manageStateChange() : void
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:BuildingTypeVisual = null;
         var _loc6_:BitmapAssetReference = null;
         var _loc4_:int = determineState();
         var _loc3_:int = ownerBuildingData.buildingInfo.level;
         var _loc2_:Array = viewMap[_loc3_ == 0 ? 0 : _loc3_ - 1][_loc4_];
         _loc5_ = 0;
         while(_loc5_ < lastStateBuildingVisualArray.length)
         {
            lastStateBuildingVisualArray[_loc5_].removeEventListener("change",onSourceChange);
            _loc5_++;
         }
         totalNewStateChangeAssetNumber = _loc2_.length;
         loadedNewStateChangeAssetNumber = 0;
         lastStateBuildingVisualArray = [];
         _loc7_ = 0;
         while(_loc7_ < _loc2_.length)
         {
            _loc1_ = _loc2_[_loc7_];
            _loc6_ = assetRepository.getBitmapAssetReference(_loc1_.id);
            lastStateBuildingVisualArray.push(_loc6_);
            _loc6_.addEventListener("change",onSourceChange);
            onSourceChange(null,_loc6_);
            _loc7_++;
         }
      }
      
      private function onSourceChange(param1:Event, param2:BitmapAssetReference = null) : void
      {
         if(owner != null && (param1 == null && param2.complete) || param1 != null && (param1.target as BitmapAssetReference).complete)
         {
            loadedNewStateChangeAssetNumber = loadedNewStateChangeAssetNumber + 1;
            if(loadedNewStateChangeAssetNumber == totalNewStateChangeAssetNumber)
            {
               manageAll();
            }
         }
      }
      
      public function manageAll() : void
      {
         manageMainVisuals();
         manageBuildingFloor(lastFloorEnabledState);
         manageScaffolds();
         manageFortifications();
         manageSoil();
         manageHealthProgressBar();
         manageUpgradeProgressBar();
         manageRecruitProgressBar();
         manageSmokes();
         compositeView.sort();
      }
      
      public function manageMainVisuals() : void
      {
         var _loc6_:int = 0;
         var _loc12_:int = 0;
         var _loc24_:int = 0;
         var _loc23_:int = 0;
         var _loc5_:Array = null;
         var _loc16_:Array = null;
         var _loc9_:Boolean = false;
         var _loc15_:Boolean = false;
         var _loc3_:int = 0;
         var _loc10_:GameSprite = null;
         var _loc18_:Class = null;
         var _loc22_:IsoBuildingProjection = null;
         var _loc21_:Point = null;
         var _loc4_:* = 0;
         var _loc7_:* = 0;
         var _loc17_:int = 0;
         var _loc20_:GameSprite = null;
         var _loc1_:GameSprite = null;
         var _loc11_:GameSprite = null;
         var _loc19_:Boolean = "MouseFollow" in owner.componentManager;
         _loc6_ = determineState();
         _loc12_ = ownerBuildingData.buildingInfo.level;
         var _loc13_:String = null;
         if(ownerBuildingData.buildingInfo.buildingTypeId == 43 && _loc6_ == 1)
         {
            _loc13_ = "AllianceBarracksCOA" + (womGameRoot.cityInfo.ownerAlliance ? womGameRoot.cityInfo.ownerAlliance.coaInfo.patternColorA.color + "x" + womGameRoot.cityInfo.ownerAlliance.coaInfo.patternColorB.color + "x" + womGameRoot.cityInfo.ownerAlliance.coaInfo.patternId : "16777215x16777215x1");
         }
         if(_loc6_ != lastState || _loc12_ != lastLevel || _loc19_ != lastMouseFollowIncludedState || _loc13_ != lastAllianceCOAId)
         {
            _loc24_ = _loc12_ == 0 ? 0 : _loc12_ - 1;
            _loc23_ = lastLevel <= 0 ? 0 : lastLevel - 1;
            _loc5_ = viewMap[_loc24_][_loc6_];
            _loc16_ = viewMap[_loc23_][lastState];
            _loc9_ = _loc5_.length == (_loc16_ ? _loc16_.length : -1) && _loc19_ == lastMouseFollowIncludedState;
            if(lastLevel == -1 && lastState == -1)
            {
               _loc9_ = false;
            }
            if(ownerBuildingData.buildingInfo.buildingTypeId == 43 && _loc6_ == 1)
            {
               if(_loc13_ != lastAllianceCOAId)
               {
                  _loc9_ = false;
                  lastAllianceCOAId = _loc13_;
               }
            }
            if(_loc9_)
            {
               for each(var _loc14_ in _loc5_)
               {
                  _loc15_ = false;
                  for each(var _loc8_ in _loc16_)
                  {
                     if(_loc8_.id == _loc14_.id)
                     {
                        _loc15_ = true;
                        break;
                     }
                  }
                  if(_loc9_)
                  {
                     _loc9_ = _loc15_;
                  }
                  if(!_loc9_)
                  {
                     break;
                  }
               }
            }
            if(!_loc9_)
            {
               clearMainVisuals();
               lastState = _loc6_;
               lastLevel = _loc12_;
               lastMouseFollowIncludedState = _loc19_;
               _loc3_ = 0;
               for each(var _loc2_ in _loc5_)
               {
                  _loc10_ = new GameSprite();
                  _loc10_.composite = ownerSprite;
                  if(_loc2_.visualType == "Animation")
                  {
                     if(notLoop)
                     {
                        _loc18_ = owner.root.render.renderSpecificActionAnimation;
                     }
                     else
                     {
                        _loc18_ = owner.root.render.renderSpecificLoopAnimation;
                     }
                     _loc10_.componentManager.add(animation = new _loc18_(_loc2_.fpsChangeRate,_loc2_.frameWidth));
                     _loc10_.componentManager.add(_loc10_.view = new AnimationAssetView(_loc2_.id,_loc2_.layer));
                     _loc10_.componentManager.add(_loc10_.position = new Position(new Point3(_loc2_.offset.x,_loc2_.offset.y,_loc3_ + 1)));
                     _loc10_.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated());
                     _loc10_.componentManager.add(_loc10_.bounds = new CompositeChildRenderBounds());
                     if(ownerBuildingData.buildingTypeDIO.id == 29)
                     {
                        _loc10_.position.point.z = 61;
                     }
                     if(specializedAnimation && "BuildingRepair" in owner.componentManager)
                     {
                        animation.requested = false;
                     }
                  }
                  else
                  {
                     _loc10_.componentManager.add(_loc10_.view = new AssetView(_loc2_.layer,_loc2_.id,false));
                     _loc10_.componentManager.add(_loc10_.position = new Position(new Point3(_loc2_.offset.x,_loc2_.offset.y,-_loc3_ - 1)));
                     _loc10_.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated());
                     _loc10_.componentManager.add(_loc10_.bounds = new CompositeChildRenderBounds());
                  }
                  if(_loc2_.mainVisual)
                  {
                     mainVisual = _loc10_.view as AssetView;
                     _loc10_.position.point.z = 0;
                     _loc22_ = owner.componentManager["BaseProjection"] as IsoBuildingProjection;
                     _loc22_.sortPoint.x = _loc2_.sortPoint.x;
                     _loc22_.sortPoint.y = _loc2_.sortPoint.y;
                  }
                  else if(_loc2_.mainVisualFront)
                  {
                     _loc10_.position.point.z = 50;
                  }
                  else if(ownerBuildingData.buildingTypeDIO.id == 43)
                  {
                     _loc10_.position.point.z = 0 + 1;
                  }
                  if(_loc2_.layer != 3)
                  {
                     owner.root.layers[_loc2_.layer].add(_loc10_);
                  }
                  else
                  {
                     compositeView.addChild(_loc10_);
                  }
                  owner.addChild(_loc10_);
                  mainVisuals.push(_loc10_);
                  _loc10_.init();
                  _loc3_++;
               }
               if(ownerBuildingData.buildingInfo.buildingTypeId == 43)
               {
                  _loc21_ = new Point(110,122);
                  _loc4_ = uint(womGameRoot.cityInfo.ownerAlliance ? womGameRoot.cityInfo.ownerAlliance.coaInfo.patternColorA.color : 16777215);
                  _loc7_ = uint(womGameRoot.cityInfo.ownerAlliance ? womGameRoot.cityInfo.ownerAlliance.coaInfo.patternColorB.color : 16777215);
                  _loc17_ = int(womGameRoot.cityInfo.ownerAlliance ? uint(womGameRoot.cityInfo.ownerAlliance.coaInfo.patternId) : 0);
                  _loc20_ = new GameSprite();
                  _loc20_.composite = owner as GameSprite;
                  _loc20_.componentManager.add(_loc20_.view = new ColoredAssetView(3,"SignEmpty",_loc4_,false));
                  _loc20_.componentManager.add(_loc20_.position = new Position(new Point3(_loc21_.x,_loc21_.y,6)));
                  _loc20_.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated());
                  _loc20_.componentManager.add(_loc20_.bounds = new CompositeChildRenderBounds());
                  owner.addChild(_loc20_);
                  compositeView.addChild(_loc20_);
                  _loc20_.init();
                  mainVisuals.push(_loc20_);
                  if(_loc17_ > 0)
                  {
                     _loc1_ = new GameSprite();
                     _loc1_.composite = owner as GameSprite;
                     _loc1_.componentManager.add(_loc1_.view = new ColoredAssetView(3,"SignIcon" + _loc17_,_loc7_,false));
                     _loc1_.componentManager.add(_loc1_.position = new Position(new Point3(_loc21_.x,_loc21_.y,8)));
                     _loc1_.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated());
                     _loc1_.componentManager.add(_loc1_.bounds = new CompositeChildRenderBounds());
                     owner.addChild(_loc1_);
                     compositeView.addChild(_loc1_);
                     _loc1_.init();
                     mainVisuals.push(_loc1_);
                  }
                  _loc11_ = new GameSprite();
                  _loc11_.composite = owner as GameSprite;
                  _loc11_.componentManager.add(_loc11_.view = new AssetView(3,"SignBlank",false));
                  _loc11_.componentManager.add(_loc11_.position = new Position(new Point3(_loc21_.x,_loc21_.y,7)));
                  _loc11_.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated());
                  _loc11_.componentManager.add(_loc11_.bounds = new CompositeChildRenderBounds());
                  owner.addChild(_loc11_);
                  compositeView.addChild(_loc11_);
                  _loc11_.init();
                  mainVisuals.push(_loc11_);
               }
               setAnimationFrameFromPercentage(initialFrameNumPercentage);
               if("TowerAnimationManager" in owner.componentManager && (owner.componentManager["TowerAnimationManager"] as TowerAnimationManager).initialized)
               {
                  (owner.componentManager["TowerAnimationManager"] as TowerAnimationManager).init();
               }
            }
         }
      }
      
      private function clearMainVisuals() : void
      {
         var _loc1_:GameSprite = null;
         var _loc2_:int = 0;
         animation = null;
         if(!mainVisuals)
         {
            mainVisuals = new Vector.<GameSprite>();
            return;
         }
         while(mainVisuals.length > 0)
         {
            _loc1_ = mainVisuals.pop();
            owner.children.splice(owner.children.indexOf(_loc1_),1);
            _loc2_ = (_loc1_.componentManager["BaseView"] as BaseView).layerId;
            if(_loc2_ == 3)
            {
               compositeView.clearChild(_loc1_);
            }
            else
            {
               owner.root.layers[_loc2_].remove(_loc1_);
            }
            _loc1_.destroy();
         }
      }
      
      public function manageScaffolds() : void
      {
         var _loc2_:ScaffoldType = null;
         var _loc1_:ScaffoldType = null;
         var _loc3_:Boolean = ownerBuildingData.buildingInfo.incomplete && ownerBuildingData.buildingInfo.healthPoint > 0;
         if(_loc3_ != lastScaffoldEnabledState)
         {
            lastScaffoldEnabledState = _loc3_;
            if(lastScaffoldEnabledState)
            {
               _loc2_ = ScaffoldType.determineScaffoldTypeByBaseSize(baseSize,"Front");
               _loc1_ = ScaffoldType.determineScaffoldTypeByBaseSize(baseSize,"Back");
               scaffoldFront = new GameSprite();
               scaffoldFront.componentManager.add(scaffoldFront.view = new AssetView(3,_loc2_.asset,false));
               scaffoldFront.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated());
               scaffoldFront.componentManager.add(scaffoldFront.bounds = new CompositeChildRenderBounds());
               scaffoldFront.componentManager.add(scaffoldFront.position = new Position(new Point3(_loc2_.offset.x,_loc2_.offset.y,60)));
               scaffoldFront.composite = ownerSprite;
               compositeView.addChild(scaffoldFront);
               owner.addChild(scaffoldFront);
               scaffoldFront.init();
               scaffoldFront.bounds.disable();
               scaffoldBack = new GameSprite();
               scaffoldBack.componentManager.add(scaffoldBack.view = new AssetView(3,_loc1_.asset,false));
               scaffoldBack.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated());
               scaffoldBack.componentManager.add(scaffoldBack.bounds = new CompositeChildRenderBounds());
               scaffoldBack.componentManager.add(scaffoldBack.position = new Position(new Point3(_loc1_.offset.x,_loc1_.offset.y,-15)));
               scaffoldBack.composite = ownerSprite;
               compositeView.addChild(scaffoldBack);
               owner.addChild(scaffoldBack);
               scaffoldBack.init();
               scaffoldBack.bounds.disable();
               compositeView.sort();
            }
            else
            {
               clearScaffolds();
            }
         }
      }
      
      private function clearScaffolds() : void
      {
         if(scaffoldBack)
         {
            compositeView.clearChild(scaffoldBack);
            owner.destroyChild(scaffoldBack);
            scaffoldBack = null;
         }
         if(scaffoldFront)
         {
            compositeView.clearChild(scaffoldFront);
            owner.destroyChild(scaffoldFront);
            scaffoldFront = null;
         }
      }
      
      public function drawIndicator(param1:String) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:BounceEffect = null;
         if(currentIndicator != param1)
         {
            clearIndicator();
            indicator = new GameSprite();
            indicator.componentManager.add(indicator.view = new AssetView(4,param1,false));
            _loc4_ = (rootProjection.pitchX * baseSize - 31) / 2 >> 0;
            _loc3_ = rootProjection.pitchY * baseSize;
            indicator.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated(true));
            indicator.componentManager.add(indicator.bounds = new CompositeChildRenderBounds());
            indicator.componentManager.add(indicator.position = new Position(new Point3(_loc4_,_loc3_,71)));
            indicator.composite = ownerSprite;
            owner.root.layers[4].add(indicator);
            owner.addChild(indicator);
            indicator.init();
            _loc2_ = new BounceEffect();
            indicator.componentManager.add(_loc2_);
            _loc2_.init();
            _loc2_.enable();
            currentIndicator = param1;
         }
      }
      
      public function clearIndicator() : void
      {
         if(indicator)
         {
            currentIndicator = null;
            owner.root.layers[4].remove(indicator);
            owner.destroyChild(indicator);
            indicator = null;
         }
      }
      
      public function manageFortifications() : void
      {
         var _loc3_:FortificationType = null;
         var _loc1_:FortificationType = null;
         var _loc2_:int = ownerBuildingData.buildingInfo.fortificationLevel;
         if(ownerBuildingData.buildingInfo.healthPoint <= 0)
         {
            _loc2_ = 0;
         }
         if(lastFortificationLevel != _loc2_)
         {
            lastFortificationLevel = _loc2_;
            clearFortifications();
            if(lastFortificationLevel > 0)
            {
               _loc3_ = FortificationType.determineFortificationType(ownerBuildingData.buildingTypeDIO.fortificationSize,ownerBuildingData.buildingInfo.fortificationLevel,"Front");
               _loc1_ = FortificationType.determineFortificationType(ownerBuildingData.buildingTypeDIO.fortificationSize,ownerBuildingData.buildingInfo.fortificationLevel,"Back");
               fortificationFront = new GameSprite();
               fortificationFront.componentManager.add(fortificationFront.view = new AssetView(3,_loc3_.asset,false));
               fortificationFront.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated());
               fortificationFront.componentManager.add(fortificationFront.bounds = new CompositeChildRenderBounds());
               fortificationFront.componentManager.add(fortificationFront.position = new Position(new Point3(_loc3_.offset.x,_loc3_.offset.y,61)));
               fortificationFront.composite = ownerSprite;
               compositeView.addChild(fortificationFront);
               owner.addChild(fortificationFront);
               fortificationFront.init();
               fortificationFront.bounds.disable();
               fortificationBack = new GameSprite();
               fortificationBack.componentManager.add(fortificationBack.view = new AssetView(3,_loc1_.asset,false));
               fortificationBack.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated());
               fortificationBack.componentManager.add(fortificationBack.bounds = new CompositeChildRenderBounds());
               fortificationBack.componentManager.add(fortificationBack.position = new Position(new Point3(_loc1_.offset.x,_loc1_.offset.y,-19)));
               fortificationBack.composite = ownerSprite;
               compositeView.addChild(fortificationBack);
               owner.addChild(fortificationBack);
               fortificationBack.init();
               fortificationBack.bounds.disable();
               compositeView.sort();
            }
         }
      }
      
      private function clearFortifications() : void
      {
         if(fortificationFront)
         {
            compositeView.clearChild(fortificationFront);
            owner.destroyChild(fortificationFront);
            fortificationFront = null;
         }
         if(fortificationBack)
         {
            compositeView.clearChild(fortificationBack);
            owner.destroyChild(fortificationBack);
            fortificationBack = null;
         }
      }
      
      public function manageBuildingFloor(param1:Boolean = false) : void
      {
         var _loc7_:StarlingAtlasReference = null;
         var _loc2_:BuildingData = null;
         var _loc5_:Number = NaN;
         var _loc4_:Matrix = null;
         var _loc6_:Number = NaN;
         var _loc3_:Number = NaN;
         if(lastFloorEnabledState != param1)
         {
            lastFloorEnabledState = param1;
            if(lastFloorEnabledState)
            {
               if(!buildingFloor)
               {
                  buildingFloor = new GameSprite();
                  buildingFloor.composite = ownerSprite;
                  _loc7_ = ownerSprite.root.atlasManager.getAtlasReference("BuildingFloor");
                  _loc2_ = (owner as Building).data;
                  buildingFloor.componentManager.add(buildingFloor.view = new AssetView(2,"BuildingFloor",true));
                  buildingFloor.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated(true));
                  buildingFloor.componentManager.add(buildingFloor.bounds = new CompositeChildRenderBounds());
                  buildingFloor.componentManager.add(buildingFloor.position = new Position(new Point3(0,0,-12)));
                  owner.addChild(buildingFloor);
                  buildingFloor.init();
                  _loc5_ = _loc2_.buildingTypeDIO.baseSize * rootProjection.pitchX / _loc7_.width;
                  _loc4_ = new Matrix();
                  _loc6_ = _loc7_.width * (_loc5_ - 1) / 2;
                  _loc3_ = _loc7_.height * (1 - _loc5_) / 2;
                  _loc4_.scale(_loc5_,_loc5_);
                  _loc4_.translate(_loc6_,_loc3_);
                  buildingFloor.view.applyMatrix(_loc4_);
               }
               owner.root.layers[2].add(buildingFloor);
            }
            else
            {
               clearBuildingFloor();
            }
         }
      }
      
      private function clearBuildingFloor() : void
      {
         if(buildingFloor)
         {
            owner.root.layers[2].remove(buildingFloor);
            owner.destroyChild(buildingFloor);
            buildingFloor = null;
         }
      }
      
      public function manageSoil() : void
      {
         var _loc1_:String = null;
         if(haveSoil && !("MouseFollow" in owner.componentManager))
         {
            soil = new GameSprite();
            _loc1_ = "Soil" + baseSize * 5;
            soil.componentManager.add(soil.view = new AssetView(2,_loc1_,false));
            soil.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated());
            soil.componentManager.add(soil.bounds = new CompositeChildRenderBounds());
            soil.componentManager.add(soil.position = new Position(new Point3(0,0,-11)));
            soil.composite = ownerSprite;
            owner.root.layers[2].add(soil);
            owner.addChild(soil);
            soil.init();
            soil.bounds.disable();
         }
         else
         {
            clearSoil();
         }
      }
      
      private function clearSoil() : void
      {
         if(soil)
         {
            owner.root.layers[2].remove(soil);
            owner.destroyChild(soil);
            soil = null;
         }
      }
      
      public function manageHealthProgressBar() : void
      {
         var _loc2_:String = null;
         var _loc1_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:int = ownerBuildingData.buildingInfo.level == 0 ? 0 : ownerBuildingData.buildingInfo.level - 1;
         var _loc10_:Number = ownerBuildingData.buildingInfo.healthPoint;
         var _loc7_:Number = ownerBuildingData.buildingTypeDIO.healthPointsPerLevel[_loc9_];
         var _loc8_:Number = (1 - _loc10_ / _loc7_) * 30;
         var _loc3_:Boolean = _loc8_ - int(_loc8_) < 0.5;
         var _loc5_:int = _loc3_ ? _loc8_ << 0 : _loc8_ + 1 << 0;
         if(_loc10_ > 0 && _loc10_ < _loc7_)
         {
            if(_loc5_ != lastHealthProgressIndex || !healthProgressBar)
            {
               lastHealthProgressIndex = _loc5_;
               if(upgradeProgressBar)
               {
                  clearUpgradeProgressBar();
               }
               _loc2_ = "BuildingHealth-" + _loc5_;
               if(healthProgressBar)
               {
                  (healthProgressBar.view as AssetView).changeAsset(_loc2_);
               }
               else
               {
                  healthProgressBar = new GameSprite();
                  _loc1_ = 43;
                  _loc6_ = (rootProjection.pitchX * baseSize - _loc1_) / 2 >> 0;
                  _loc4_ = rootProjection.pitchY * baseSize;
                  healthProgressBar.componentManager.add(healthProgressBar.view = new AssetView(4,_loc2_));
                  healthProgressBar.componentManager.add(healthProgressBar.position = new Position(new Point3(_loc6_,_loc4_,70)));
                  healthProgressBar.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated(true));
                  healthProgressBar.componentManager.add(healthProgressBar.bounds = new CompositeChildRenderBounds());
                  healthProgressBar.composite = ownerSprite;
                  owner.root.layers[4].add(healthProgressBar);
                  owner.addChild(healthProgressBar);
                  healthProgressBar.init();
                  healthProgressBar.bounds.disable();
               }
            }
         }
         else
         {
            lastHealthProgressIndex = _loc10_ == 0 ? -1 : _loc5_;
            clearHealthProgressBar();
         }
      }
      
      private function clearHealthProgressBar() : void
      {
         if(healthProgressBar)
         {
            owner.root.layers[4].remove(healthProgressBar);
            owner.destroyChild(healthProgressBar);
            healthProgressBar = null;
            lastHealthProgressIndex = -1;
         }
      }
      
      public function manageUpgradeProgressBar() : void
      {
         var _loc2_:BuildingUpgradeJob = null;
         var _loc10_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc1_:int = 0;
         var _loc4_:String = null;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:int = ownerBuildingData.buildingInfo.level == 0 ? 0 : ownerBuildingData.buildingInfo.level - 1;
         var _loc11_:Number = ownerBuildingData.buildingInfo.healthPoint;
         var _loc8_:Number = ownerBuildingData.buildingTypeDIO.healthPointsPerLevel[_loc9_];
         if(womGameRoot.userInfo.gameMode == GameModeType.NORMAL && _loc11_ == _loc8_ && "BuildingUpgrade" in owner.componentManager && (owner.componentManager["BuildingUpgrade"] as BuildingUpgrade).buildingUpgradeJob)
         {
            _loc2_ = (owner.componentManager["BuildingUpgrade"] as BuildingUpgrade).buildingUpgradeJob as BuildingUpgradeJob;
            _loc10_ = Math.max(0,Math.min(10,10 - (_loc2_.jobCreationTime + _loc2_.durationRemaining - new Date().getTime()) / _loc2_.originalDuration * 10));
            _loc5_ = _loc10_ - int(_loc10_) < 0.5;
            _loc1_ = 10 - (_loc5_ ? _loc10_ << 0 : _loc10_ + 1 << 0);
            if(lastUpgradeProgressIndex != _loc1_)
            {
               lastUpgradeProgressIndex = _loc1_;
               _loc4_ = "BuildingProgress-" + _loc1_;
               if(upgradeProgressBar)
               {
                  (upgradeProgressBar.view as AssetView).changeAsset(_loc4_);
               }
               else
               {
                  upgradeProgressBar = new GameSprite();
                  _loc3_ = 58;
                  _loc7_ = (rootProjection.pitchX * baseSize - _loc3_) / 2 >> 0;
                  _loc6_ = rootProjection.pitchY * baseSize + 10;
                  upgradeProgressBar.componentManager.add(upgradeProgressBar.view = new AssetView(4,_loc4_));
                  upgradeProgressBar.componentManager.add(upgradeProgressBar.position = new Position(new Point3(_loc7_,_loc6_,70)));
                  upgradeProgressBar.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated(true));
                  upgradeProgressBar.componentManager.add(upgradeProgressBar.bounds = new CompositeChildRenderBounds());
                  upgradeProgressBar.composite = ownerSprite;
                  owner.root.layers[4].add(upgradeProgressBar);
                  owner.addChild(upgradeProgressBar);
                  upgradeProgressBar.init();
                  upgradeProgressBar.bounds.disable();
               }
            }
         }
         else
         {
            lastUpgradeProgressIndex = -1;
            clearUpgradeProgressBar();
         }
      }
      
      private function clearUpgradeProgressBar() : void
      {
         if(upgradeProgressBar)
         {
            owner.root.layers[4].remove(upgradeProgressBar);
            owner.destroyChild(upgradeProgressBar);
            upgradeProgressBar = null;
         }
      }
      
      public function manageRecruitProgressBar() : void
      {
         var _loc8_:UnitRecruitJob = null;
         var _loc1_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc7_:int = 0;
         var _loc3_:String = null;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(ownerBuildingData.buildingTypeDIO.id != 17)
         {
            return;
         }
         if(womGameRoot.userInfo.gameMode == GameModeType.NORMAL && "UnitRecruit" in owner.componentManager && (owner.componentManager["UnitRecruit"] as UnitRecruit).unitRecruitJob)
         {
            _loc8_ = (owner.componentManager["UnitRecruit"] as UnitRecruit).unitRecruitJob as UnitRecruitJob;
            _loc1_ = Math.max(0,Math.min(10,10 - (_loc8_.jobCreationTime + _loc8_.durationRemaining - new Date().getTime()) / _loc8_.originalDuration * 10));
            _loc4_ = _loc1_ - int(_loc1_) < 0.5;
            _loc7_ = 10 - (_loc4_ ? _loc1_ << 0 : _loc1_ + 1 << 0);
            if(lastRecruitProgressIndex != _loc7_)
            {
               lastRecruitProgressIndex = _loc7_;
               _loc3_ = "RecruitProgress-" + _loc7_;
               if(recruitProgressBar)
               {
                  (recruitProgressBar.componentManager["BaseView"] as AssetView).changeAsset(_loc3_);
               }
               else
               {
                  recruitProgressBar = new GameSprite();
                  _loc2_ = 54;
                  _loc6_ = (rootProjection.pitchX * baseSize - _loc2_) / 2 >> 0;
                  _loc5_ = rootProjection.pitchY * baseSize + 10;
                  recruitProgressBar.componentManager.add(recruitProgressBar.view = new AssetView(4,_loc3_));
                  recruitProgressBar.componentManager.add(recruitProgressBar.position = new Position(new Point3(_loc6_,_loc5_,70)));
                  recruitProgressBar.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated(true));
                  recruitProgressBar.componentManager.add(recruitProgressBar.bounds = new CompositeChildRenderBounds());
                  recruitProgressBar.composite = ownerSprite;
                  owner.root.layers[4].add(recruitProgressBar);
                  owner.addChild(recruitProgressBar);
                  recruitProgressBar.init();
                  recruitProgressBar.bounds.disable();
               }
            }
         }
         else
         {
            lastRecruitProgressIndex = -1;
            clearRecruitProgressBar();
         }
      }
      
      private function clearRecruitProgressBar() : void
      {
         if(recruitProgressBar)
         {
            owner.root.layers[4].remove(recruitProgressBar);
            owner.destroyChild(recruitProgressBar);
            recruitProgressBar = null;
         }
      }
      
      public function clearAllVisuals() : void
      {
         var _loc1_:GameSprite = null;
         var _loc2_:int = 0;
         if(owner)
         {
            while(owner.children.length > 0)
            {
               _loc1_ = owner.children[0] as GameSprite;
               if("Wander" in _loc1_.componentManager)
               {
                  owner.children.splice(0,1);
               }
               else
               {
                  _loc2_ = _loc1_.view.layerId;
                  if(_loc2_ == 3)
                  {
                     compositeView.clearChild(_loc1_);
                  }
                  else
                  {
                     owner.root.layers[_loc2_].remove(_loc1_);
                  }
                  owner.destroyChild(_loc1_);
               }
            }
         }
      }
      
      private function determineState() : int
      {
         if(ownerBuildingData.buildingInfo.isTrap)
         {
            if(ownerBuildingData.buildingInfo.healthPoint == 0)
            {
               return 3;
            }
            return 1;
         }
         if(ownerBuildingData.buildingTypeDIO.indestructable)
         {
            return 1;
         }
         var _loc1_:int = ownerBuildingData.buildingInfo.healthPoint;
         if(_loc1_ <= 0)
         {
            return 3;
         }
         if(_loc1_ > ownerBuildingData.buildingTypeDIO.healthPointsPerLevel[ownerBuildingData.buildingInfo.level == 0 ? 0 : ownerBuildingData.buildingInfo.level - 1] >> 1)
         {
            return 1;
         }
         return 2;
      }
      
      override public function disable() : void
      {
         clearAllVisuals();
         super.disable();
      }
      
      public function startAnimation() : void
      {
         if(animation)
         {
            if(removeAnimationIfDisabled && compositeView.children.indexOf(animation.ownerSprite) == -1)
            {
               compositeView.addChild(animation.ownerSprite);
            }
            if(animation.prepared)
            {
               animation.enable();
            }
            else
            {
               animation.requested = true;
            }
         }
      }
      
      public function stopAnimation() : void
      {
         if(animation)
         {
            if(removeAnimationIfDisabled)
            {
               compositeView.clearChild(animation.ownerSprite);
            }
            if(animation.prepared)
            {
               animation.disable();
            }
            else
            {
               animation.requested = false;
            }
         }
      }
      
      public function setAnimationFrameFromPercentage(param1:Number) : void
      {
         initialFrameNumPercentage = param1 > 1 ? 1 : param1;
         if(ownerBuildingData.buildingTypeDIO.id == 15 && animation && animation is ActionAnimation)
         {
            (animation as ActionAnimation).setFrame(12 * initialFrameNumPercentage << 0);
         }
      }
      
      public function addDamageSmoke(param1:Boolean = false, param2:int = -1, param3:int = -1) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(ownerBuildingData.buildingTypeDIO.id == 41)
         {
            return;
         }
         var _loc6_:GameSprite = new GameSprite();
         if(param2 == -1)
         {
            _loc4_ = Math.random() * (rootProjection.pitchX * baseSize / 4);
            _loc5_ = Math.random() * (rootProjection.pitchX * baseSize / 4);
            param2 = _loc4_ - _loc5_ + rootProjection.pitchX * baseSize / 2;
            param3 = (_loc4_ + _loc5_) / 2 + rootProjection.pitchY * baseSize / 4;
         }
         _loc6_.componentManager.add(new owner.root.render.renderSpecificLoopAnimation(3,96));
         _loc6_.componentManager.add(_loc6_.view = new AnimationAssetView("DamagedSmoke",3));
         _loc6_.componentManager.add(_loc6_.position = new Position(new Point3(param2 - 48,param3,65)));
         _loc6_.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated(true));
         _loc6_.componentManager.add(_loc6_.bounds = new CompositeChildRenderBounds());
         _loc6_.composite = ownerSprite;
         owner.addChild(_loc6_);
         _loc6_.init();
         sfx.startBurn();
         compositeView.addChild(_loc6_);
         smokes.push(_loc6_);
      }
      
      private function addDestroySmoke(param1:int = -1, param2:int = -1) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(ownerBuildingData.buildingTypeDIO.id == 41)
         {
            return;
         }
         var _loc5_:GameSprite = new GameSprite();
         if(param1 == -1)
         {
            _loc3_ = Math.random() * (rootProjection.pitchX * baseSize / 4);
            _loc4_ = Math.random() * (rootProjection.pitchX * baseSize / 4);
            param1 = _loc3_ - _loc4_ + rootProjection.pitchX * baseSize / 2;
            param2 = (_loc3_ + _loc4_) / 2 + rootProjection.pitchY * baseSize / 4;
         }
         _loc5_.componentManager.add(new owner.root.render.renderSpecificLoopAnimation(3,37));
         _loc5_.componentManager.add(_loc5_.view = new AnimationAssetView("DestroyedSmoke",3));
         _loc5_.componentManager.add(_loc5_.position = new Position(new Point3(param1 - 18.5,param2,65)));
         _loc5_.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated(true));
         _loc5_.componentManager.add(_loc5_.bounds = new CompositeChildRenderBounds());
         _loc5_.composite = ownerSprite;
         owner.addChild(_loc5_);
         _loc5_.init();
         compositeView.addChild(_loc5_);
         smokes.push(_loc5_);
      }
      
      public function swicthFireWithSmokes() : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:GameSprite = null;
         var _loc4_:Vector.<GameSprite> = smokes;
         smokes = new Vector.<GameSprite>();
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc2_ = Math.random() * 3;
            if(_loc2_ == 0)
            {
               addDestroySmoke(_loc4_[_loc5_].position.point.x + 48,_loc4_[_loc5_].position.point.y);
            }
            else
            {
               addDamageSmoke(false,_loc4_[_loc5_].position.point.x + 48,_loc4_[_loc5_].position.point.y);
            }
            _loc5_++;
         }
         _loc3_ = _loc4_.length - 1;
         while(_loc3_ >= 0)
         {
            _loc1_ = _loc4_[_loc3_];
            compositeView.clearChild(_loc1_);
            owner.destroyChild(_loc1_);
            _loc3_--;
         }
         _loc4_.length = 0;
      }
      
      public function manageSmokes() : void
      {
         var _loc3_:int = 0;
         var _loc1_:GameSprite = null;
         _loc3_ = smokes.length - 1;
         while(_loc3_ >= 0)
         {
            _loc1_ = smokes[_loc3_];
            compositeView.clearChild(_loc1_);
            owner.destroyChild(_loc1_);
            _loc3_--;
         }
         smokes.length = 0;
         if(ownerBuildingData.buildingTypeDIO.indestructable)
         {
            return;
         }
         var _loc2_:Number = ownerBuildingData.buildingTypeDIO.healthPointsPerLevel[ownerBuildingData.buildingInfo.level == 0 ? 0 : ownerBuildingData.buildingInfo.level - 1];
         if(ownerBuildingData.buildingInfo.healthPoint <= _loc2_ * 0.7)
         {
            addDestroySmoke();
         }
         if(ownerBuildingData.buildingInfo.healthPoint <= _loc2_ * 0.3 && ownerBuildingData.buildingTypeDIO.baseSize > 15)
         {
            addDestroySmoke();
         }
      }
      
      public function removeSmoke() : void
      {
         var _loc1_:GameSprite = smokes.pop();
         if(!_loc1_)
         {
            return;
         }
         compositeView.clearChild(_loc1_);
         owner.destroyChild(_loc1_);
      }
      
      public function drawMobileMoveArrows() : void
      {
         var _loc12_:int = 0;
         var _loc8_:GameSprite = null;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:String = null;
         var _loc3_:String = null;
         var _loc9_:HeightRevertedBuildingPartProjectionDeprecated = null;
         clearMobileMoveArrows();
         compositeView.alphaFilterMain(0.7);
         var _loc1_:Array = ["Left","Top","Bottom","Right"];
         var _loc10_:int = baseSize * rootProjection.pitchX / 4;
         var _loc6_:int = baseSize * rootProjection.pitchX * 3 / 4;
         var _loc11_:int = baseSize * rootProjection.pitchY / 4;
         var _loc5_:int = baseSize * rootProjection.pitchY * 3 / 4;
         _loc12_ = 0;
         while(_loc12_ < 4)
         {
            _loc8_ = new GameSprite();
            _loc4_ = int(_loc12_ / 2) == 0 ? _loc10_ : _loc6_;
            _loc2_ = _loc12_ % 2 == 0 ? _loc11_ : _loc5_;
            _loc7_ = _loc1_[_loc12_];
            _loc3_ = "Arrow" + _loc7_;
            _loc8_.componentManager.add(_loc8_.view = new AssetView(4,_loc3_,false));
            _loc8_.componentManager.add(_loc8_.position = new Position(new Point3(_loc4_,_loc2_,70)));
            _loc9_ = new HeightRevertedBuildingPartProjectionDeprecated(true);
            _loc8_.componentManager.add(_loc9_);
            _loc8_.componentManager.add(_loc8_.bounds = new CompositeChildRenderBounds());
            _loc8_.composite = ownerSprite;
            owner.addChild(_loc8_);
            _loc8_.init();
            if(int(_loc12_ / 2) == 0)
            {
               _loc8_.position.move(_loc8_.position.point.x - _loc8_.bounds.width,_loc8_.position.point.y,_loc8_.position.point.z);
            }
            if(_loc12_ % 2 == 0)
            {
               _loc8_.position.move(_loc8_.position.point.x,_loc8_.position.point.y - _loc8_.bounds.height,_loc8_.position.point.z);
            }
            _loc8_.position.refreshPosition();
            owner.root.layers[4].add(_loc8_);
            mobileMoveArrows.push(_loc8_);
            _loc12_++;
         }
      }
      
      public function clearMobileMoveArrows() : void
      {
         compositeView.alphaFilterMain();
         if(mobileMoveArrows)
         {
            for each(var _loc1_ in mobileMoveArrows)
            {
               owner.root.layers[4].remove(_loc1_);
               owner.destroyChild(_loc1_);
            }
         }
         mobileMoveArrows = new Vector.<GameSprite>();
      }
      
      public function drawMobileTutorialArrow(param1:int, param2:int, param3:String) : void
      {
         clearMobileTutorialArrow();
         var _loc6_:int = (baseSize * rootProjection.pitchX - 58 >> 1) + param1;
         var _loc5_:int = baseSize * rootProjection.pitchY + param2;
         mobileTutorialArrow = new GameSprite();
         mobileTutorialArrow.componentManager.add(mobileTutorialArrow.view = new AssetView(4,param3,false));
         mobileTutorialArrow.componentManager.add(mobileTutorialArrow.position = new Position(new Point3(_loc6_,_loc5_,70)));
         mobileTutorialArrow.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated(true));
         mobileTutorialArrow.componentManager.add(mobileTutorialArrow.bounds = new CompositeChildRenderBounds());
         mobileTutorialArrow.composite = ownerSprite;
         owner.addChild(mobileTutorialArrow);
         mobileTutorialArrow.init();
         owner.root.layers[4].add(mobileTutorialArrow);
         var _loc4_:BounceEffect = new BounceEffect();
         mobileTutorialArrow.componentManager.add(_loc4_);
         _loc4_.init();
         _loc4_.enable();
      }
      
      public function clearMobileTutorialArrow() : void
      {
         if(mobileTutorialArrow)
         {
            owner.root.layers[4].remove(mobileTutorialArrow);
            owner.destroyChild(mobileTutorialArrow);
         }
         mobileTutorialArrow = null;
      }
      
      public function prepareAssetsForDestruction() : void
      {
         var _loc1_:BuildingTypeVisual = null;
         var _loc2_:Array = null;
         var _loc5_:int = determineState();
         var _loc3_:int = ownerBuildingData.buildingInfo.level;
         var _loc6_:int = _loc3_ == 0 ? 0 : _loc3_ - 1;
         var _loc4_:Vector.<String> = new Vector.<String>();
         switch(_loc5_ - 1)
         {
            case 0:
               _loc2_ = viewMap[_loc6_][2];
               var _loc8_:int = 0;
               var _loc7_:Array = _loc2_;
               while(true)
               {
                  for each(_loc1_ in _loc7_)
                  {
                     _loc4_.push(_loc1_.id);
                     continue;
                  }
               }
            case 1:
               _loc2_ = viewMap[_loc6_][3];
               var _loc10_:int = 0;
               var _loc9_:Array = _loc2_;
               while(§§hasnext(_loc9_,_loc10_))
               {
                  _loc1_ = §§nextvalue(_loc10_,_loc9_);
                  _loc4_.push(_loc1_.id);
               }
         }
         assetRepository.preload(_loc4_);
      }
      
      public function prepareAssetsForRepair() : void
      {
         var _loc1_:BuildingTypeVisual = null;
         var _loc2_:Array = null;
         var _loc5_:int = determineState();
         var _loc3_:int = ownerBuildingData.buildingInfo.level;
         var _loc6_:int = _loc3_ == 0 ? 0 : _loc3_ - 1;
         var _loc4_:Vector.<String> = new Vector.<String>();
         switch(_loc5_ - 2)
         {
            case 1:
               _loc2_ = viewMap[_loc6_][2];
               for each(_loc1_ in _loc2_)
               {
                  _loc4_.push(_loc1_.id);
               }
            case 0:
               _loc2_ = viewMap[_loc6_][1];
               var _loc10_:int = 0;
               var _loc9_:Array = _loc2_;
               while(§§hasnext(_loc9_,_loc10_))
               {
                  _loc1_ = §§nextvalue(_loc10_,_loc9_);
                  _loc4_.push(_loc1_.id);
               }
         }
         assetRepository.preload(_loc4_);
      }
      
      public function manageRangeView(param1:Boolean) : void
      {
         var _loc3_:BuildingRangeManager = null;
         var _loc2_:StarlingAtlasReference = null;
         if(BuildingSpecificInfoType.RANGES_PER_LEVEL_IN_PX.id in ownerBuildingData.buildingTypeDIO.buildingSpecificInfo)
         {
            if(param1)
            {
               if(!rangeView)
               {
                  rangeView = new GameSprite();
                  _loc3_ = new BuildingRangeManager();
                  rangeView.componentManager.add(_loc3_);
                  rangeView.composite = ownerSprite;
                  _loc2_ = ownerSprite.root.atlasManager.getAtlasReference("TowerRange");
                  rangeView.componentManager.add(rangeView.view = new AssetView(2,"TowerRange",true));
                  rangeView.componentManager.add(new BuildingPartProjection(true));
                  rangeView.componentManager.add(rangeView.bounds = new CompositeChildRenderBounds());
                  rangeView.componentManager.add(rangeView.position = new Position(new Point3(0,0,-12)));
                  owner.addChild(rangeView);
                  rangeView.init();
                  rangeView.position.point.x = _loc2_.width / -2;
                  rangeView.position.point.y = _loc2_.height / 2;
                  rangeView.position.refreshPosition();
                  rangeView.view.scaleFixed(0.001);
                  (owner.root.layers[2] as Layer).add(rangeView);
               }
               else
               {
                  (rangeView.componentManager["BuildingRangeManager"] as BuildingRangeManager).reAnimate();
               }
            }
            else if(rangeView)
            {
               (rangeView.componentManager["BuildingRangeManager"] as BuildingRangeManager).remove();
            }
         }
      }
      
      public function clearRangeView() : void
      {
         var _loc1_:GameSprite = null;
         if(rangeView)
         {
            _loc1_ = rangeView;
            rangeView = null;
            (owner.root.layers[2] as Layer).remove(_loc1_);
            owner.removeChild(_loc1_);
            _loc1_.destroy();
         }
      }
   }
}

