package wom.model.component
{
   import flash.events.IEventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.Root;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.Viewport;
   import peak.cuckoo.game.attribute.projection.BaseProjection;
   import peak.cuckoo.game.behavior.MouseInteract;
   import peak.cuckoo.game.behavior.TimeOut;
   import peak.cuckoo.game.behavior.cull.ViewingFrustumCull;
   import peak.cuckoo.game.behavior.render.BaseRender;
   import peak.cuckoo.game.behavior.sort.ZSort;
   import peak.cuckoo.game.dto.Point3;
   import peak.display.ViewportResizeEvent;
   import peak.resource.SoundPlayer;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.controller.event.ui.GetMapListWindowEvent;
   import wom.controller.event.ui.TownOptionsMenuEvent;
   import wom.model.component.attribute.data.MapTileData;
   import wom.model.component.attribute.projection.MapProjection;
   import wom.model.component.attribute.view.MapView;
   import wom.model.component.attribute.viewManager.MapFlagViewManager;
   import wom.model.component.behavior.cull.MapViewingFrustumCull;
   import wom.model.component.entity.gamesprite.MapFlag;
   import wom.model.component.enum.MapDirection;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.domain.DomainInfo;
   import wom.model.dto.MapMemberInfo;
   import wom.model.game.Profile;
   import wom.model.game.UserInfo;
   import wom.model.game.WomScreenType;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.experience.ExperienceUtil;
   import wom.model.game.tutorial.TutorialListInfo;
   import wom.model.message.request.GetMapInfoRequest;
   import wom.model.message.response.GetMapInfoResponse;
   import wom.model.resource.WomAssetRepository;
   import wom.service.facebook.FacebookAPIManager;
   
   public class WomMapRoot extends Root
   {
      
      public static const MAP_SIZE:int = 41;
      
      public var projectionMap:MapProjection;
      
      public var towns:Vector.<GameSprite>;
      
      public var flags:Vector.<GameSprite>;
      
      public const TILE_WIDTH:int = 131;
      
      public const TILE_HEIGHT:int = 94;
      
      [Inject]
      public var eventDispatcher:IEventDispatcher;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public var tiles:Array;
      
      public var friendsOnMap:Dictionary;
      
      public var nonFriendsOnMap:Dictionary;
      
      public var allianceEnemies:Dictionary;
      
      public var revanchists:Dictionary;
      
      public var mapMemberInfos:Dictionary;
      
      private var mapLayout:Object;
      
      private var firstTown:Boolean = true;
      
      private var _inTutorial:Boolean = false;
      
      public var memberDataList:Vector.<MapTileData>;
      
      public var townSlotCount:int = 0;
      
      public function WomMapRoot()
      {
         super();
         componentManager.add(projectionMap = new MapProjection());
         componentManager.add(render = BaseRender.getRender(2));
         componentManager.add(viewport = new Viewport(new Rectangle(85.5,141,131 * (41 - 2),94 * (41 - 2))));
         componentManager.add(userInteract = new MouseInteract("arrow"));
         componentManager.add(timeOut = new TimeOut());
         initFields();
         createLayers();
      }
      
      public static function getAssetName(param1:int) : String
      {
         return "Part" + param1;
      }
      
      public function initFields() : void
      {
         var _loc1_:int = 0;
         townSlotCount = 0;
         firstTown = true;
         friendsOnMap = new Dictionary();
         nonFriendsOnMap = new Dictionary();
         mapMemberInfos = new Dictionary();
         tiles = [];
         _loc1_ = 0;
         while(_loc1_ < 41)
         {
            tiles[_loc1_] = [];
            _loc1_++;
         }
         towns = new Vector.<GameSprite>();
         flags = new Vector.<GameSprite>();
         memberDataList = new Vector.<MapTileData>();
      }
      
      override protected function createLayers() : void
      {
         layers = [];
         var _loc1_:Layer = new Layer(2);
         _loc1_.componentManager.add(_loc1_.projection = new BaseProjection());
         _loc1_.componentManager.add(_loc1_.cull = new ViewingFrustumCull());
         layers[2] = _loc1_;
         addChild(_loc1_);
         _loc1_ = new Layer(3);
         _loc1_.componentManager.add(_loc1_.cull = new MapViewingFrustumCull());
         _loc1_.componentManager.add(_loc1_.sort = new ZSort());
         layers[3] = _loc1_;
         addChild(_loc1_);
      }
      
      public function clearVisualContent() : void
      {
         for each(var _loc1_ in layers)
         {
            for each(var _loc2_ in towns)
            {
               _loc1_.remove(_loc2_);
               removeChild(_loc2_);
            }
            for each(var _loc3_ in flags)
            {
               _loc1_.remove(_loc3_);
               removeChild(_loc3_);
            }
         }
      }
      
      override public function init() : void
      {
         super.init();
         userInteract.click.addFunction(onMouseClick);
         getMapInfoRequest();
         mapLayout = domainInfo.getMapLayout()["tiles"];
         eventDispatcher.addEventListener("platformUsersUpdated",onPlatformUsersUpdated);
         eventDispatcher.addEventListener("eventNpcsUpdated",onEventNpcsUpdated);
         eventDispatcher.addEventListener("getMapTownPosition",onMapTownPositionRequested);
         eventDispatcher.addEventListener("centerMapMember",centerMapMember);
         eventDispatcher.addEventListener("resize",onViewportResize);
         eventDispatcher.addEventListener("resize",onViewportResize);
      }
      
      private function onEventNpcsUpdated(param1:ModelUpdateEvent) : void
      {
         removeEventNpcs();
      }
      
      protected function onViewportResize(param1:ViewportResizeEvent) : void
      {
         timeOut.addJobToFrame(1,triggerTutorial);
      }
      
      private function triggerTutorial() : void
      {
         eventDispatcher.dispatchEvent(new TutorialTriggerEvent("defaultActionTriggered"));
      }
      
      protected function onMouseClick() : void
      {
         var _loc1_:MapTileData = null;
         var _loc2_:GameSprite = userInteract.pickedEntity;
         if(_loc2_)
         {
            _loc1_ = _loc2_.componentManager["MapTileData"];
         }
         if(_loc2_ && _loc1_ && _loc1_.mapMemberInfo)
         {
            if(_loc1_.mapMemberInfo.isCurrentUser)
            {
               eventDispatcher.dispatchEvent(new TownOptionsMenuEvent("closeTownOptionsMenu"));
               eventDispatcher.dispatchEvent(new ActivateScreenEvent("activate",WomScreenType.CITY));
            }
            else
            {
               eventDispatcher.dispatchEvent(new TownOptionsMenuEvent("showTownOptionsMenu",_loc1_));
            }
         }
         else
         {
            eventDispatcher.dispatchEvent(new TownOptionsMenuEvent("closeTownOptionsMenu"));
         }
      }
      
      public function getMapInfoRequest() : void
      {
         eventDispatcher.dispatchEvent(new OutgoingMessageEvent("outgoingMessage",new GetMapInfoRequest()));
      }
      
      public function fillMap() : void
      {
         var _loc7_:GameSprite = null;
         townSlotCount = 0;
         var _loc8_:int = 20;
         var _loc5_:int = 20;
         var _loc2_:int = 1681;
         var _loc1_:int = 0;
         var _loc3_:MapDirection = MapDirection.LEFT;
         var _loc4_:int = 1;
         var _loc6_:int = 1;
         while(_loc1_ < _loc2_)
         {
            if(_loc8_ >= 0 && _loc8_ < 41 && _loc5_ >= 0 && _loc5_ < 41)
            {
               addTile(_loc8_,_loc5_);
               _loc1_++;
            }
            switch(_loc3_)
            {
               case MapDirection.RIGHT:
                  _loc5_++;
                  if(_loc6_++ == _loc4_)
                  {
                     _loc6_ = 1;
                     _loc3_ = MapDirection.BOTTOM;
                  }
                  break;
               case MapDirection.BOTTOM:
                  _loc8_++;
                  if(_loc6_++ == _loc4_)
                  {
                     _loc6_ = 1;
                     _loc3_ = MapDirection.LEFT;
                     _loc4_++;
                  }
                  break;
               case MapDirection.LEFT:
                  _loc5_--;
                  if(_loc6_++ == _loc4_)
                  {
                     _loc6_ = 1;
                     _loc3_ = MapDirection.TOP;
                  }
                  break;
               case MapDirection.TOP:
                  _loc8_--;
                  if(_loc6_++ == _loc4_)
                  {
                     _loc6_ = 1;
                     _loc3_ = MapDirection.RIGHT;
                     _loc4_++;
                  }
            }
         }
         _loc8_ = 0;
         while(_loc8_ < 41)
         {
            _loc5_ = 0;
            while(_loc5_ < 41)
            {
               _loc7_ = tiles[_loc8_][_loc5_];
               addChild(_loc7_);
               layers[2].add(_loc7_);
               _loc7_.init();
               _loc5_ += 2;
            }
            _loc5_ = 1;
            while(_loc5_ < 41)
            {
               _loc7_ = tiles[_loc8_][_loc5_];
               addChild(_loc7_);
               layers[2].add(_loc7_);
               _loc7_.init();
               _loc5_ += 2;
            }
            _loc8_++;
         }
         eventDispatcher.dispatchEvent(new GetMapListWindowEvent("mapReady"));
         eventDispatcher.dispatchEvent(new TutorialTriggerEvent("defaultActionTriggered"));
      }
      
      public function addTile(param1:int, param2:int) : void
      {
         var _loc3_:Position = null;
         var _loc10_:GameSprite = null;
         var _loc5_:MapTileData = null;
         var _loc12_:int = 0;
         var _loc9_:MapMemberInfo = null;
         var _loc11_:MapFlag = null;
         var _loc6_:Position = null;
         var _loc8_:Profile = null;
         var _loc7_:Boolean = false;
         var _loc4_:String = null;
         var _loc13_:MapView = null;
         if(param1 < 41 && param2 < 41 && !tiles[param1][param2])
         {
            _loc10_ = new GameSprite();
            if(firstTown)
            {
               firstTown = false;
               _loc9_ = new MapMemberInfo(userInfo.profile,0,ExperienceUtil.calculateLevelOfExperience(userInfo.experiencePoints),userInfo.battlePoints,true,0,0,0,false,userInfo.mandatoryTutorialCompleted,false,allianceInfo.myAllianceSummary,false,false,false,false,false);
               _loc9_.isCurrentUser = true;
               _loc12_ = int(mapLayout[param1][param2][0]);
               _loc5_ = new MapTileData(_loc12_,_loc9_);
               _loc11_ = new MapFlag();
               _loc11_.componentManager.add(_loc11_.data = _loc5_);
               _loc11_.componentManager.add(_loc11_.viewManager = new MapFlagViewManager(_loc11_));
               _loc11_.componentManager.add(new MapProjection());
               _loc11_.interactive = true;
               _loc3_ = new Position(generateMapPoint(param1,param2,_loc5_.assetId));
               _loc6_ = new Position(new Point3(_loc3_.point.x + mapLayout[param1][param2][1],_loc3_.point.y + mapLayout[param1][param2][2],0));
               _loc11_.componentManager.add(_loc11_.position = _loc6_);
               towns.push(_loc10_);
               flags.push(_loc11_);
               layers[3].add(_loc11_);
               addChild(_loc11_);
               _loc11_.init();
               townSlotCount = townSlotCount + 1;
            }
            else if(mapLayout[param1][param2] is Array)
            {
               _loc8_ = null;
               _loc7_ = !(townSlotCount in mapMemberInfos);
               if(!_loc7_)
               {
                  _loc9_ = mapMemberInfos[townSlotCount];
                  if(_inTutorial)
                  {
                     _loc8_ = TutorialListInfo.getProfileAccordingToTutorial(_loc9_.profile,userInfo.tutorialsInfo);
                     _loc7_ ||= _loc8_.isNpc && _loc8_.npcId != "NPC_D";
                  }
                  else
                  {
                     _loc7_ ||= _loc9_.profile.isNpc && !_loc9_.isEventNpc;
                  }
               }
               if(_loc7_)
               {
                  _loc5_ = new MapTileData(7,null);
               }
               else
               {
                  _loc12_ = int(mapLayout[param1][param2][0]);
                  _loc5_ = new MapTileData(_loc12_,_loc9_);
                  _loc11_ = new MapFlag();
                  _loc11_.componentManager.add(_loc11_.data = _loc5_);
                  _loc11_.componentManager.add(_loc11_.viewManager = new MapFlagViewManager(_loc11_,_loc8_));
                  _loc11_.componentManager.add(new MapProjection());
                  _loc11_.interactive = true;
                  _loc3_ = new Position(generateMapPoint(param1,param2,_loc5_.assetId));
                  _loc6_ = new Position(new Point3(_loc3_.point.x + mapLayout[param1][param2][1],_loc3_.point.y + mapLayout[param1][param2][2],0));
                  _loc11_.componentManager.add(_loc11_.position = _loc6_);
                  _loc5_.townInfoPosition = new Point(_loc6_.point.x + 81,_loc6_.point.y + 8);
                  towns.push(_loc10_);
                  flags.push(_loc11_);
                  layers[3].add(_loc11_);
                  addChild(_loc11_);
                  _loc11_.init();
                  memberDataList.push(_loc5_);
               }
               townSlotCount = townSlotCount + 1;
            }
            else
            {
               _loc12_ = int(mapLayout[param1][param2]);
               _loc5_ = new MapTileData(_loc12_,null);
            }
            _loc4_ = getAssetName(_loc5_.assetId);
            _loc13_ = new MapView(2,assetRepository.getBitmapAssetReference(_loc4_),_loc4_,_loc5_);
            _loc10_.componentManager.add(_loc10_.view = _loc13_);
            _loc10_.componentManager.add(new MapProjection());
            _loc10_.componentManager.add(_loc10_.position = new Position(generateMapPoint(param1,param2,_loc5_.assetId)));
            tiles[param1][param2] = _loc10_;
         }
      }
      
      public function generateMapPoint(param1:Number, param2:Number, param3:int = -1) : Point3
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(param2 % 2 == 1)
         {
            param1 += 0.5;
         }
         switch(param3 - 1)
         {
            case 0:
               _loc5_ = -3;
               _loc4_ = 19;
               break;
            case 1:
               _loc5_ = -2;
               _loc4_ = 15;
               break;
            case 2:
               _loc5_ = -3;
               _loc4_ = 10;
               break;
            case 3:
               _loc5_ = -3;
               _loc4_ = 23;
               break;
            case 4:
               _loc5_ = -3;
               _loc4_ = 32;
               break;
            case 5:
               _loc5_ = -3;
               _loc4_ = 57;
               break;
            case 6:
               _loc5_ = -3;
               _loc4_ = 10;
               break;
            case 7:
               _loc5_ = 0;
               _loc4_ = 44;
               break;
            case 8:
               _loc5_ = -2;
               _loc4_ = 17;
               break;
            case 9:
               _loc5_ = -2;
               _loc4_ = 7;
               break;
            case 10:
               _loc5_ = -1;
               _loc4_ = 15;
               break;
            case 11:
               _loc5_ = 0;
               _loc4_ = 57;
               break;
            case 12:
               _loc5_ = -1;
               _loc4_ = 80;
         }
         return new Point3(param2 * 131 - _loc5_,param1 * 94 - _loc4_);
      }
      
      override public function keyPressed(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 37)
         {
            viewport.rect.x -= 5;
         }
         else if(param1.keyCode == 39)
         {
            viewport.rect.x += 5;
         }
         else if(param1.keyCode == 38)
         {
            viewport.rect.y -= 5;
         }
         else if(param1.keyCode == 40)
         {
            viewport.rect.y += 5;
         }
         else if(param1.keyCode == 107)
         {
            render.zoomIn();
         }
         else if(param1.keyCode == 109)
         {
            render.zoomOut();
         }
      }
      
      public function mapInfoReceived(param1:GetMapInfoResponse) : void
      {
         _inTutorial = TutorialListInfo.checkInNpcRevengeTutorial(userInfo.tutorialsInfo);
         friendsOnMap = param1.friendsOnMap;
         nonFriendsOnMap = param1.nonFriendsOnMap;
         allianceEnemies = param1.allianceEnemies;
         revanchists = param1.revanchists;
         mapMemberInfos = param1.mapMemberInfos;
         fillMap();
         platformUsersUpdated();
      }
      
      private function onPlatformUsersUpdated(param1:ModelUpdateEvent) : void
      {
         platformUsersUpdated();
      }
      
      protected function platformUsersUpdated() : void
      {
         updateTownInfos();
      }
      
      private function updateTownInfos() : void
      {
         var _loc2_:String = null;
         var _loc4_:Profile = null;
         var _loc3_:MapFlagViewManager = null;
         for each(var _loc1_ in flags)
         {
            _loc4_ = TutorialListInfo.getProfileAccordingToTutorial(_loc1_.data.mapMemberInfo.profile,userInfo.tutorialsInfo);
            _loc2_ = facebookAPIManager.getUserNameByProfile(_loc4_);
            _loc1_.data.mapMemberInfo.visibleName = _loc2_;
            _loc3_ = _loc1_.viewManager;
            _loc3_.updateName(_loc2_);
            _loc3_.updateAvatar(_loc4_);
         }
      }
      
      public function removeEventNpcs() : void
      {
         var _loc3_:int = 0;
         var _loc2_:MapFlag = null;
         var _loc1_:MapTileData = null;
         _loc3_ = flags.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = flags[_loc3_] as MapFlag;
            _loc1_ = _loc2_.data;
            if(_loc1_.mapMemberInfo.isEventNpc)
            {
               (layers[_loc2_.view.layerId] as Layer).remove(_loc2_);
               destroyChild(_loc2_);
               flags.splice(_loc3_,1);
            }
            _loc3_--;
         }
         _loc3_ = memberDataList.length - 1;
         while(_loc3_ >= 0)
         {
            _loc1_ = memberDataList[_loc3_];
            if(_loc1_.mapMemberInfo.isEventNpc)
            {
               memberDataList.splice(_loc3_,1);
            }
            _loc3_--;
         }
      }
      
      override public function reset() : void
      {
         clearVisualContent();
         initFields();
         super.reset();
      }
      
      protected function getMapMemberTownInfo(param1:String) : MapFlag
      {
         var _loc2_:MapTileData = null;
         for each(var _loc3_ in flags)
         {
            _loc2_ = _loc3_.data;
            if(_loc2_.mapMemberInfo.profile.npcId != null && _loc2_.mapMemberInfo.profile.npcId == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      protected function onMapTownPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         var _loc2_:MapFlag = null;
         if("mapMemberId" in param1.additionalInfo)
         {
            _loc2_ = getMapMemberTownInfo(param1.additionalInfo["mapMemberId"]);
            if(_loc2_ != null)
            {
               _loc2_.bounds.update();
               eventDispatcher.dispatchEvent(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,new Point(_loc2_.bounds.point.x,_loc2_.bounds.point.y)));
            }
         }
      }
      
      protected function centerMapMember(param1:TutorialTriggerEvent) : void
      {
         var _loc2_:GameSprite = null;
         if("mapMemberId" in param1.additionalInfo)
         {
            _loc2_ = getMapMemberTownInfo(param1.additionalInfo["mapMemberId"]);
            if(_loc2_ != null)
            {
               _loc2_.bounds.update();
               viewport.centerTo(_loc2_.position.point.x,_loc2_.position.point.y);
            }
         }
      }
   }
}

