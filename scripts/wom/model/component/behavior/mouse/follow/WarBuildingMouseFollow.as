package wom.model.component.behavior.mouse.follow
{
   import flash.utils.Dictionary;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.bounds.compositeBased.CompositeChildRenderBounds;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.dto.Point3;
   import peak.resource.atlas.starling.StarlingAtlasReference;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.projection.HeightRevertedBuildingPartProjectionDeprecated;
   import wom.model.component.attribute.view.WomFilters;
   import wom.model.component.behavior.BuildingRangeManager;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Decoration;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.BattleField;
   
   public class WarBuildingMouseFollow extends ConstructableMouseFollow
   {
      
      private const WAR_BUILDING_BOUNDARY:int = 50;
      
      private var ownerDecoration:Decoration;
      
      private var rangeView:GameSprite;
      
      private var range:int;
      
      private var womRoot:WomGameRoot;
      
      public var collidedBuildings:Dictionary;
      
      public var collidedUnits:Dictionary;
      
      private var radius:Number;
      
      private var rangeSquare:Number;
      
      private var targetBuilding:Boolean;
      
      private var targetUnit:Boolean;
      
      public function WarBuildingMouseFollow(param1:Boolean = false, param2:int = 0, param3:Boolean = true, param4:Boolean = false)
      {
         super(param1);
         this.range = param2;
         this.targetBuilding = param3;
         this.targetUnit = param4;
      }
      
      override public function init() : void
      {
         super.init();
         womRoot = owner.root as WomGameRoot;
         ownerDecoration = owner as Decoration;
         radius = range;
         rangeSquare = radius * radius;
         addRangeView();
      }
      
      override public function onSignal0() : void
      {
         var _loc16_:Point3 = null;
         var _loc2_:Dictionary = null;
         var _loc6_:Dictionary = null;
         var _loc10_:* = 0;
         var _loc8_:* = 0;
         var _loc1_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc18_:int = 0;
         var _loc11_:BattleField = null;
         var _loc17_:Boolean = false;
         var _loc20_:Boolean = false;
         var _loc19_:int = 0;
         var _loc15_:int = 0;
         var _loc14_:int = 0;
         var _loc9_:int = 0;
         var _loc5_:Building = null;
         var _loc13_:Unit = null;
         var _loc4_:* = null;
         var _loc12_:* = null;
         super.onSignal0();
         if(rangeView)
         {
            _loc16_ = new Point3();
            owner.root.projection.transform(new Point3(ownerDecoration.position.point.x + ownerDecoration.data.dio.baseSize / 2,ownerDecoration.position.point.y + ownerDecoration.data.dio.baseSize / 2),_loc16_);
            _loc2_ = new Dictionary();
            _loc6_ = new Dictionary();
            _loc1_ = (target.x - radius) / 10;
            _loc7_ = (target.x + radius) / 10;
            _loc3_ = (target.y - radius) / 10;
            _loc18_ = (target.y + radius) / 10;
            if(_loc1_ < 0)
            {
               _loc1_--;
            }
            if(_loc7_ > 0)
            {
               _loc7_++;
            }
            if(_loc3_ < 0)
            {
               _loc3_--;
            }
            if(_loc18_ > 0)
            {
               _loc18_++;
            }
            _loc10_ = _loc1_;
            while(_loc10_ <= _loc7_)
            {
               _loc8_ = _loc3_;
               while(_loc8_ <= _loc18_)
               {
                  _loc11_ = womRoot.battleManager.battleFieldControl.battleFields[(_loc10_ << 10) + (_loc8_ << 0)] as BattleField;
                  if(_loc11_)
                  {
                     _loc17_ = targetBuilding && _loc11_.buildings;
                     _loc20_ = targetUnit && _loc11_.defenceUnits;
                     if(_loc17_ || _loc20_)
                     {
                        _loc19_ = _loc10_ * 10 - target.x;
                        _loc15_ = _loc8_ * 10 - target.y;
                        _loc14_ = _loc19_ * _loc19_ + _loc15_ * _loc15_;
                        if(_loc14_ < rangeSquare)
                        {
                           if(_loc17_)
                           {
                              _loc9_ = 0;
                              while(_loc9_ < _loc11_.buildings.length)
                              {
                                 _loc5_ = _loc11_.buildings[_loc9_];
                                 if(!_loc5_.data.buildingTypeDIO.indestructable)
                                 {
                                    _loc2_[_loc5_.id] = _loc5_;
                                    _loc5_.filterManager.addFilter(WomFilters.PURPLE_FILTER);
                                 }
                                 _loc9_++;
                              }
                           }
                           if(_loc20_)
                           {
                              _loc9_ = 0;
                              while(_loc9_ < _loc11_.defenceUnits.length)
                              {
                                 _loc13_ = _loc11_.defenceUnits[_loc9_];
                                 _loc6_[_loc13_.id] = _loc13_;
                                 _loc13_.filterManager.addFilter(WomFilters.PURPLE_FILTER);
                                 _loc9_++;
                              }
                           }
                        }
                     }
                  }
                  _loc8_++;
               }
               _loc10_++;
            }
         }
         if(collidedBuildings)
         {
            for each(_loc4_ in collidedBuildings)
            {
               if(!(_loc4_.id in _loc2_))
               {
                  _loc4_.filterManager.removeFilter(WomFilters.PURPLE_FILTER);
               }
            }
         }
         collidedBuildings = _loc2_;
         if(collidedUnits)
         {
            for each(_loc12_ in collidedUnits)
            {
               if(!(_loc12_.id in _loc6_))
               {
                  _loc12_.filterManager.removeFilter(WomFilters.PURPLE_FILTER);
               }
            }
         }
         collidedUnits = _loc6_;
      }
      
      private function onClick() : void
      {
         if(!collide)
         {
            (owner.root as WomGameRoot).eventItemsManager.buildWarBuilding(target.x,target.y);
         }
      }
      
      override public function destroy() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         removeRangeView();
         if(collidedBuildings)
         {
            for each(_loc2_ in collidedBuildings)
            {
               _loc2_.filterManager.removeFilter(WomFilters.PURPLE_FILTER);
            }
         }
         if(collidedUnits)
         {
            for each(_loc1_ in collidedUnits)
            {
               _loc1_.filterManager.removeFilter(WomFilters.PURPLE_FILTER);
            }
         }
         super.destroy();
      }
      
      public function addRangeView() : void
      {
         var _loc3_:BuildingRangeManager = null;
         var _loc2_:StarlingAtlasReference = null;
         var _loc1_:Point3 = null;
         if(!rangeView && range > 0)
         {
            rangeView = new GameSprite();
            _loc3_ = new BuildingRangeManager(range);
            rangeView.componentManager.add(_loc3_);
            rangeView.composite = ownerDecoration;
            _loc2_ = ownerDecoration.root.atlasManager.getAtlasReference("TowerRange");
            rangeView.componentManager.add(rangeView.view = new AssetView(2,"TowerRange",true));
            rangeView.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated(true));
            rangeView.componentManager.add(rangeView.bounds = new CompositeChildRenderBounds());
            rangeView.componentManager.add(rangeView.position = new Position(new Point3(0,0,-12)));
            owner.addChild(rangeView);
            rangeView.init();
            rangeView.view.scaleFixed(0.001);
            _loc1_ = new Point3();
            owner.root.projection.transform(new Point3(ownerDecoration.position.point.x + ownerDecoration.data.dio.baseSize / 2,ownerDecoration.position.point.y + ownerDecoration.data.dio.baseSize / 2),_loc1_);
            rangeView.position.projected.x = _loc1_.x - rangeView.view.width / 2;
            rangeView.position.projected.y = _loc1_.y - rangeView.view.height / 2;
            var _loc5_:GameSprite = rangeView;
            _loc5_.validator.add(_loc5_);
            undefined;
            (owner.root.layers[2] as Layer).add(rangeView);
         }
      }
      
      public function removeRangeView() : void
      {
         if(rangeView)
         {
            owner.root.layers[2].remove(rangeView);
            owner.destroyChild(rangeView);
            rangeView = null;
         }
      }
   }
}

