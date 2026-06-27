package wom.model.component.behavior.mouse.follow
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.dto.Point3;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.attribute.projection.IsoBuildingProjection;
   import wom.model.component.attribute.viewManager.BuildingViewManager;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.BuildingTypeInfo;
   import wom.model.game.resource.ResourceType;
   import wom.model.message.request.ConstructBuildingRequest;
   
   public class MultiBuildMouseFollow extends BuildingMouseFollow
   {
      
      private static const BUILDING_SIZE:int = 4;
      
      private static const WALL_GOLD_PRICE:int = 10;
      
      private static const WALL_LUMBER_PRICE:int = 1000;
      
      private static const HARD_LIMIT:int = 30;
      
      private var ownerSprite:GameSprite;
      
      private var x:Number;
      
      private var y:Number;
      
      private var ghostFill:Boolean;
      
      private var resourceLimit:Number;
      
      private var ghosts:Vector.<Building>;
      
      private var womRoot:WomGameRoot;
      
      private var buildingDomainInfo:BuildingTypeDIO;
      
      private var buildingTypeInfo:BuildingTypeInfo;
      
      private var containerPoint:Point3 = new Point3();
      
      public function MultiBuildMouseFollow(param1:Boolean)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         ownerSprite = owner as GameSprite;
         womRoot = owner.root as WomGameRoot;
         buildingDomainInfo = womRoot.domainInfo.getBuilding(41);
         buildingTypeInfo = womRoot.cityInfo.buildingTypes[41];
         ghosts = new Vector.<Building>();
      }
      
      override public function updateState(param1:Point3) : void
      {
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc10_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc4_:int = 0;
         var _loc9_:int = 0;
         containerPoint.x = param1.x;
         containerPoint.y = param1.y;
         if(ghostFill)
         {
            for each(var _loc2_ in ghosts)
            {
               owner.root.layers[3].remove(_loc2_);
               womRoot.removeChild(_loc2_);
               _loc2_.destroy();
            }
            ghosts.length = 0;
            _loc3_ = param1.x - x;
            _loc5_ = param1.y - y;
            _loc6_ = _loc3_ < 0 ? -1 : 1;
            _loc7_ = _loc5_ < 0 ? -1 : 1;
            _loc3_ *= _loc6_;
            _loc5_ *= _loc7_;
            if(_loc3_ > _loc5_)
            {
               _loc10_ = 4 * _loc6_;
               _loc4_ = _loc3_ / 4;
               _loc8_ = _loc5_ * 4 * _loc7_ / _loc3_;
            }
            else
            {
               _loc8_ = 4 * _loc7_;
               _loc4_ = _loc5_ / 4;
               _loc10_ = _loc3_ * 4 * _loc6_ / _loc5_;
            }
            if(womRoot.buildByGold)
            {
               resourceLimit = womRoot.userInfo.numberOfGolds / 10;
            }
            else
            {
               resourceLimit = womRoot.cityInfo.resourceAmounts[ResourceType.LUMBER.id] / 1000;
            }
            if(buildingTypeInfo.maxInstanceCount - buildingTypeInfo.currentInstanceCount < resourceLimit)
            {
               resourceLimit = buildingTypeInfo.maxInstanceCount - buildingTypeInfo.currentInstanceCount;
            }
            _loc9_ = 1;
            while(_loc9_ < _loc4_ && _loc9_ <= 30 && resourceLimit > 1)
            {
               createGhost(x + _loc9_ * _loc10_,y + _loc9_ * _loc8_);
               _loc9_++;
            }
            containerPoint.x = x + _loc9_ * _loc10_;
            containerPoint.y = y + _loc9_ * _loc8_;
         }
         super.updateState(containerPoint);
      }
      
      private function createGhost(param1:int, param2:int) : void
      {
         var _loc3_:BuildingInfo = new BuildingInfo(1,-1,buildingDomainInfo.id,buildingDomainInfo.healthPointsPerLevel[0],new Point(0,0));
         var _loc4_:Building = new Building();
         _loc4_.componentManager.add(_loc4_.viewManager = new BuildingViewManager(_loc4_,buildingDomainInfo));
         _loc4_.componentManager.add(_loc4_.position = new Position(new Point3(param1,param2,0)));
         _loc4_.componentManager.add(_loc4_.data = new BuildingData(_loc3_,buildingTypeInfo,buildingDomainInfo));
         _loc4_.componentManager.add(new IsoBuildingProjection(buildingDomainInfo.baseSize,buildingDomainInfo.visualMap.sortPoint));
         _loc4_.composite = _loc4_;
         womRoot.addChild(_loc4_);
         _loc4_.init();
         owner.root.layers[3].add(_loc4_);
         collide = cityGrid.checkCollision(new Rectangle(param1,param2,4,4),isDecoration ? 50 : 0);
         _loc4_.viewManager.compositeView.alphaFilterMain(0.5);
         if(collide)
         {
            _loc4_.viewManager.compositeView.colorFilterMain(11141120);
         }
         else
         {
            _loc4_.viewManager.compositeView.colorFilterMain();
            resourceLimit = resourceLimit - 1;
         }
         ghosts.push(_loc4_);
      }
      
      override public function warnNewDeploy(param1:Point3) : void
      {
         if(womRoot.buildByGold)
         {
            resourceLimit = womRoot.userInfo.numberOfGolds / 10;
         }
         else
         {
            resourceLimit = womRoot.cityInfo.resourceAmounts[ResourceType.LUMBER.id] / 1000;
         }
         for each(var _loc2_ in ghosts)
         {
            collide = cityGrid.checkCollision(new Rectangle(_loc2_.position.point.x,_loc2_.position.point.y,4,4),isDecoration ? 50 : 0);
            if(!collide && resourceLimit > 1)
            {
               womRoot.eventDispatcher.dispatchEvent(new OutgoingMessageEvent("outgoingMessage",new ConstructBuildingRequest(buildingTypeInfo.constructTypeId,_loc2_.position.point.x,_loc2_.position.point.y,womRoot.buildByGold,womRoot.completeResources)));
               resourceLimit = resourceLimit - 1;
            }
         }
         clearAllGhosts();
         super.warnNewDeploy(param1);
         x = param1.x;
         y = param1.y;
         var _loc3_:int = 3;
         while(cityGrid.checkCollision(new Rectangle(x + _loc3_ * 4,y,4,4),200))
         {
            _loc3_++;
         }
         param1.x += _loc3_ * 4;
         ghostFill = true;
         updateState(param1);
      }
      
      private function clearAllGhosts() : void
      {
         for each(var _loc1_ in ghosts)
         {
            womRoot.layers[3].remove(_loc1_);
            womRoot.removeChild(_loc1_);
            _loc1_.destroy();
         }
         ghosts.length = 0;
      }
      
      override public function destroy() : void
      {
         clearAllGhosts();
         super.destroy();
      }
   }
}

