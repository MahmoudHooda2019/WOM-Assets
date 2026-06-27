package wom.model.component.attribute.viewManager
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.bounds.compositeBased.CompositeChildRenderBounds;
   import peak.cuckoo.game.attribute.bounds.compositeBased.CompositeRenderBounds;
   import peak.cuckoo.game.attribute.projection.IsoProjection;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.attribute.view.BaseView;
   import peak.cuckoo.game.attribute.view.ColoredAssetView;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import peak.cuckoo.game.dto.Point3;
   import peak.resource.AssetRepository;
   import peak.resource.atlas.starling.StarlingAtlasReference;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.data.DecorationData;
   import wom.model.component.attribute.projection.HeightRevertedBuildingPartProjectionDeprecated;
   import wom.model.component.entity.gamesprite.Decoration;
   import wom.model.domain.domaininfoobject.DecorationTypeDIO;
   import wom.model.game.building.DecorationInfo;
   
   public class DecorationViewManager extends Attribute
   {
      
      public static const TYPE_ID:String = "DecorationViewManager";
      
      public static const ZINDEX_BUILDING_FLOOR:int = -12;
      
      private var womGameRoot:WomGameRoot;
      
      private var info:DecorationInfo;
      
      private var dio:DecorationTypeDIO;
      
      private var mainVisuals:Vector.<GameSprite>;
      
      private var assetRepository:AssetRepository;
      
      public var compositeView:CompositeView;
      
      private var lastFloorEnabledState:Boolean = false;
      
      private var visualId:String;
      
      private var decorationFloor:GameSprite;
      
      private var rootProjection:IsoProjection;
      
      private var baseSize:int;
      
      private var mobileMoveArrows:Vector.<GameSprite> = new Vector.<GameSprite>();
      
      private var offset:Point;
      
      public function DecorationViewManager(param1:Decoration)
      {
         super();
         param1.componentManager.add(param1.view = new CompositeView());
         compositeView = param1.view as CompositeView;
         param1.componentManager.add(param1.bounds = new CompositeRenderBounds());
      }
      
      override public function get typeId() : String
      {
         return "DecorationViewManager";
      }
      
      override public function init() : void
      {
         if(initialized)
         {
            return;
         }
         super.init();
         womGameRoot = owner.root as WomGameRoot;
         mainVisuals = new Vector.<GameSprite>();
         info = (owner as Decoration).data.info;
         dio = (owner as Decoration).data.dio;
         assetRepository = womGameRoot.assetRepository;
         baseSize = dio.baseSize;
         var _loc1_:Decoration = owner as Decoration;
         rootProjection = womGameRoot.projection as IsoProjection;
         offset = dio.offset;
         manageAll();
      }
      
      private function determineVisualId() : void
      {
         visualId = dio.visual + (info.subType ? info.subType : "");
      }
      
      override public function enable() : void
      {
         super.enable();
         (owner as GameSprite).view.init();
      }
      
      override public function disable() : void
      {
         clearAllVisuals();
         super.disable();
      }
      
      public function manageAll() : void
      {
         manageMainVisual();
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
      
      public function manageMainVisual() : void
      {
         var _loc8_:GameSprite = null;
         var _loc3_:GameSprite = null;
         var _loc7_:String = null;
         var _loc2_:* = 0;
         var _loc5_:* = 0;
         var _loc4_:int = 0;
         var _loc1_:GameSprite = null;
         var _loc6_:GameSprite = null;
         clearMainVisual();
         determineVisualId();
         if(dio.id == 114)
         {
            _loc8_ = new GameSprite();
            _loc8_.composite = owner as GameSprite;
            _loc8_.componentManager.add(_loc8_.view = new AssetView(3,"FlagFabric" + info.subType,false));
            _loc8_.componentManager.add(_loc8_.position = new Position(new Point3(offset.x + 2,offset.y + 25,0)));
            _loc8_.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated());
            _loc8_.componentManager.add(_loc8_.bounds = new CompositeChildRenderBounds());
            owner.addChild(_loc8_);
            compositeView.addChild(_loc8_);
            _loc8_.init();
            mainVisuals.push(_loc8_);
            _loc3_ = new GameSprite();
            _loc3_.composite = owner as GameSprite;
            _loc3_.componentManager.add(_loc3_.view = new AssetView(3,"FlagBlank",false));
            _loc3_.componentManager.add(_loc3_.position = new Position(new Point3(offset.x,offset.y,0)));
            _loc3_.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated());
            _loc3_.componentManager.add(_loc3_.bounds = new CompositeChildRenderBounds());
            owner.addChild(_loc3_);
            compositeView.addChild(_loc3_);
            _loc3_.init();
            mainVisuals.push(_loc3_);
         }
         else if(dio.id == 115)
         {
            _loc7_ = womGameRoot.cityInfo.ownerAlliance ? womGameRoot.cityInfo.ownerAlliance.coaInfo.patternColorA.color + "x" + womGameRoot.cityInfo.ownerAlliance.coaInfo.patternColorB.color + "x" + womGameRoot.cityInfo.ownerAlliance.coaInfo.patternId : "16777215x16777215x0";
            _loc2_ = uint(_loc7_.substring(0,_loc7_.indexOf("x")));
            _loc5_ = uint(_loc7_.substring(_loc7_.indexOf("x") + 1,_loc7_.lastIndexOf("x")));
            _loc4_ = int(_loc7_.substring(_loc7_.lastIndexOf("x") + 1));
            _loc8_ = new GameSprite();
            _loc8_.composite = owner as GameSprite;
            _loc8_.componentManager.add(_loc8_.view = new ColoredAssetView(3,"FlagEmpty",_loc2_,false));
            _loc8_.componentManager.add(_loc8_.position = new Position(new Point3(offset.x + 1,offset.y + 21,0)));
            _loc8_.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated());
            _loc8_.componentManager.add(_loc8_.bounds = new CompositeChildRenderBounds());
            owner.addChild(_loc8_);
            compositeView.addChild(_loc8_);
            _loc8_.init();
            mainVisuals.push(_loc8_);
            if(_loc4_ > 0)
            {
               _loc1_ = new GameSprite();
               _loc1_.composite = owner as GameSprite;
               _loc1_.componentManager.add(_loc1_.view = new ColoredAssetView(3,"FlagIcon" + _loc4_,_loc5_,false));
               _loc1_.componentManager.add(_loc1_.position = new Position(new Point3(offset.x + 1,offset.y + 21,0)));
               _loc1_.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated());
               _loc1_.componentManager.add(_loc1_.bounds = new CompositeChildRenderBounds());
               owner.addChild(_loc1_);
               compositeView.addChild(_loc1_);
               _loc1_.init();
               mainVisuals.push(_loc1_);
            }
            _loc3_ = new GameSprite();
            _loc3_.composite = owner as GameSprite;
            _loc3_.componentManager.add(_loc3_.view = new AssetView(3,"FlagBlank",false));
            _loc3_.componentManager.add(_loc3_.position = new Position(new Point3(offset.x,offset.y,0)));
            _loc3_.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated());
            _loc3_.componentManager.add(_loc3_.bounds = new CompositeChildRenderBounds());
            owner.addChild(_loc3_);
            compositeView.addChild(_loc3_);
            _loc3_.init();
            mainVisuals.push(_loc3_);
         }
         else
         {
            _loc6_ = new GameSprite();
            _loc6_.composite = owner as GameSprite;
            _loc6_.componentManager.add(_loc6_.view = new AssetView(3,visualId,false));
            _loc6_.componentManager.add(_loc6_.position = new Position(new Point3(offset.x,offset.y,0)));
            _loc6_.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated());
            _loc6_.componentManager.add(_loc6_.bounds = new CompositeChildRenderBounds());
            owner.addChild(_loc6_);
            compositeView.addChild(_loc6_);
            _loc6_.init();
            mainVisuals.push(_loc6_);
         }
      }
      
      private function clearMainVisual() : void
      {
         var _loc1_:GameSprite = null;
         var _loc2_:int = 0;
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
      
      public function manageBuildingFloor(param1:Boolean = false) : void
      {
         var _loc2_:DecorationData = null;
         var _loc7_:StarlingAtlasReference = null;
         var _loc5_:Number = NaN;
         var _loc4_:Matrix = null;
         var _loc6_:Number = NaN;
         var _loc3_:Number = NaN;
         if(lastFloorEnabledState != param1)
         {
            lastFloorEnabledState = param1;
            if(lastFloorEnabledState)
            {
               if(!decorationFloor)
               {
                  decorationFloor = new GameSprite();
                  decorationFloor.composite = owner as GameSprite;
                  _loc2_ = (owner as Decoration).data;
                  _loc7_ = owner.root.atlasManager.getAtlasReference("BuildingFloor");
                  decorationFloor.componentManager.add(decorationFloor.view = new AssetView(2,"BuildingFloor",true));
                  decorationFloor.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated(true));
                  decorationFloor.componentManager.add(decorationFloor.bounds = new CompositeChildRenderBounds());
                  decorationFloor.componentManager.add(decorationFloor.position = new Position(new Point3(0,0,-12)));
                  owner.addChild(decorationFloor);
                  decorationFloor.init();
                  _loc5_ = _loc2_.dio.baseSize * rootProjection.pitchX / _loc7_.width;
                  _loc4_ = new Matrix();
                  _loc6_ = _loc7_.width * (_loc5_ - 1) / 2;
                  _loc3_ = _loc7_.height * (1 - _loc5_) / 2;
                  _loc4_.scale(_loc5_,_loc5_);
                  _loc4_.translate(_loc6_,_loc3_);
                  decorationFloor.view.applyMatrix(_loc4_);
               }
               owner.root.layers[2].add(decorationFloor);
            }
            else
            {
               clearBuildingFloor();
            }
         }
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
            _loc8_.componentManager.add(_loc8_.position = new Position(new Point3(_loc4_,_loc2_,1)));
            _loc9_ = new HeightRevertedBuildingPartProjectionDeprecated(true);
            _loc8_.componentManager.add(_loc9_);
            _loc8_.componentManager.add(_loc8_.bounds = new CompositeChildRenderBounds());
            _loc8_.composite = owner as GameSprite;
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
      
      private function clearBuildingFloor() : void
      {
         if(decorationFloor)
         {
            owner.root.layers[2].remove(decorationFloor);
            owner.destroyChild(decorationFloor);
            decorationFloor = null;
         }
      }
   }
}

