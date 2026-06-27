package wom.model.component
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.Viewport;
   import peak.cuckoo.game.behavior.ScreenPan;
   import peak.cuckoo.game.behavior.StarlingTouchInteract;
   import peak.cuckoo.game.behavior.TimeOut;
   import peak.cuckoo.game.behavior.cull.ViewingFrustumCull;
   import peak.cuckoo.game.behavior.render.BaseRender;
   import peak.cuckoo.game.behavior.sort.ZSort;
   import peak.cuckoo.game.dto.Point3;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.controller.event.ui.GetMapListWindowEvent;
   import wom.controller.event.ui.TownOptionsMenuEvent;
   import wom.model.component.attribute.data.MapTileData;
   import wom.model.component.attribute.data.SpotList;
   import wom.model.component.attribute.projection.CampaignMapProjection;
   import wom.model.component.attribute.projection.DoodadProjection;
   import wom.model.component.attribute.view.DoodadView;
   import wom.model.component.attribute.view.MapView;
   import wom.model.component.attribute.view.SpotView;
   import wom.model.component.attribute.viewManager.MapFlagViewManager;
   import wom.model.component.entity.gamesprite.Doodad;
   import wom.model.component.entity.gamesprite.MapFlag;
   import wom.model.component.entity.gamesprite.Spot;
   import wom.model.dto.MapMemberInfo;
   import wom.model.game.CampaignMapInfo;
   import wom.model.message.response.GetMapInfoResponse;
   
   public class WomCampaignRoot extends WomMapRoot
   {
      
      private static const MAP_SIZE_X:int = 18;
      
      private static const MAP_SIZE_Y:int = 22;
      
      private static var canvasWidth:int = 3000;
      
      private static var canvasHeight:int = 1800;
      
      private static const npcIdMap:Object = {
         59:"NPC_4",
         60:"NPC_2",
         61:"NPC_3",
         62:"NPC_1"
      };
      
      [Inject]
      public var campaignMapInfo:CampaignMapInfo;
      
      private var doodads:Array;
      
      private var spots:Dictionary;
      
      private var npcInfos:Dictionary;
      
      private var tileLayout:Object;
      
      private var doodadLayout:Array;
      
      private var spotLayout:Array;
      
      public var screenPan:ScreenPan;
      
      public function WomCampaignRoot()
      {
         super();
         componentManager.add(render = BaseRender.getRender(4));
         componentManager.add(viewport = new Viewport(new Rectangle(-canvasWidth / 2 + 100,-canvasHeight / 2 + 50,canvasWidth - 300,canvasHeight - 200)));
         componentManager.add(screenPan = new ScreenPan());
         componentManager.add(userInteract = new StarlingTouchInteract());
         componentManager.add(timeOut = new TimeOut());
      }
      
      override public function init() : void
      {
         var _loc1_:Object = domainInfo.getCampaignLayout();
         tileLayout = _loc1_["tiles"];
         doodadLayout = _loc1_["doodads"];
         spotLayout = _loc1_["spots"];
         super.init();
         userInteract.moveDrag.addFunction(onMoveDrag);
         mapInfoReceived(null);
      }
      
      private function onMoveDrag() : void
      {
         viewport.moveTo(userInteract.grabbedCanvasPoint.x - userInteract.moveDiff.x,userInteract.grabbedCanvasPoint.y - userInteract.moveDiff.y);
      }
      
      override public function initFields() : void
      {
         var _loc1_:int = 0;
         super.initFields();
         npcInfos = new Dictionary();
         tiles = [];
         _loc1_ = 0;
         while(_loc1_ < 18)
         {
            tiles[_loc1_] = [];
            _loc1_++;
         }
         doodads = [];
         spots = new Dictionary();
         spots["NPC_1"] = new SpotList();
         spots["NPC_2"] = new SpotList();
         spots["NPC_3"] = new SpotList();
         spots["NPC_4"] = new SpotList();
         flags = new Vector.<GameSprite>();
      }
      
      override protected function createLayers() : void
      {
         layers = [];
         var _loc1_:Layer = new Layer(2);
         _loc1_.componentManager.add(_loc1_.cull = new ViewingFrustumCull());
         _loc1_.componentManager.add(_loc1_.sort = new ZSort());
         layers[2] = _loc1_;
         addChild(_loc1_);
         _loc1_ = new Layer(3);
         _loc1_.componentManager.add(_loc1_.cull = new ViewingFrustumCull());
         _loc1_.componentManager.add(_loc1_.sort = new ZSort());
         layers[3] = _loc1_;
         addChild(_loc1_);
      }
      
      override public function clearVisualContent() : void
      {
         for each(var _loc2_ in layers)
         {
            for each(var _loc3_ in doodads)
            {
               _loc2_.remove(_loc3_);
               removeChild(_loc3_);
            }
            for each(var _loc1_ in flags)
            {
               _loc2_.remove(_loc1_);
               removeChild(_loc1_);
            }
         }
      }
      
      override public function fillMap() : void
      {
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:GameSprite = null;
         townSlotCount = 0;
         _loc5_ = 0;
         while(_loc5_ < 18)
         {
            _loc2_ = 0;
            while(_loc2_ < 22)
            {
               addTile(_loc5_,_loc2_);
               _loc4_ = tiles[_loc5_][_loc2_];
               addChild(_loc4_);
               layers[2].add(_loc4_);
               _loc4_.init();
               _loc2_++;
            }
            _loc5_++;
         }
         var _loc3_:Array = doodadLayout;
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            addDoodad(_loc3_[_loc5_][0],_loc3_[_loc5_][1],_loc3_[_loc5_][2],false);
            _loc5_++;
         }
         var _loc1_:Array = spotLayout;
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_[_loc5_].length)
            {
               addDoodad(_loc1_[_loc5_][_loc2_][0],_loc1_[_loc5_][_loc2_][1],_loc1_[_loc5_][_loc2_][2],true,_loc2_);
               _loc2_++;
            }
            _loc5_++;
         }
         eventDispatcher.dispatchEvent(new GetMapListWindowEvent("mapReady"));
         eventDispatcher.dispatchEvent(new TutorialTriggerEvent("defaultActionTriggered"));
      }
      
      public function addDoodad(param1:int, param2:int, param3:int, param4:Boolean = false, param5:int = -1) : void
      {
         var _loc7_:String = null;
         var _loc9_:MapMemberInfo = null;
         var _loc10_:int = 0;
         var _loc11_:Spot = null;
         var _loc8_:MapFlag = null;
         var _loc6_:Position = null;
         var _loc12_:Doodad = param4 ? new Spot() : new Doodad();
         _loc12_.componentManager.add(_loc12_.view = param4 ? new SpotView(assetRepository) : new DoodadView(getAssetName(param1),assetRepository));
         _loc12_.componentManager.add(_loc12_.position = new Position(new Point3(param2,param3,param4 ? 1000 : 0)));
         _loc12_.componentManager.add(new DoodadProjection());
         (layers[3] as Layer).add(_loc12_);
         addChild(_loc12_);
         _loc12_.init();
         if(param4)
         {
            _loc7_ = npcIdMap[param1];
            _loc9_ = npcInfos[_loc7_];
            _loc10_ = _loc9_.level;
            _loc11_ = _loc12_ as Spot;
            _loc11_.list = spots[_loc7_];
            if(_loc11_.list.tail)
            {
               _loc11_.prev = _loc11_.list.tail;
               _loc11_.list.tail.next = _loc11_;
               _loc11_.list.tail = _loc11_;
            }
            else
            {
               _loc11_.prev = null;
               _loc11_.list.tail = _loc11_.list.head = _loc11_;
            }
            _loc11_.next = null;
            (_loc11_.view as SpotView).toggleSpotView(param5 < _loc10_);
            if(param5 == _loc10_)
            {
               _loc8_ = new MapFlag();
               _loc8_.componentManager.add(_loc8_.data = new MapTileData(param1,_loc9_));
               _loc8_.componentManager.add(_loc8_.viewManager = new MapFlagViewManager(_loc8_));
               _loc8_.componentManager.add(new DoodadProjection());
               _loc8_.interactive = true;
               _loc6_ = new Position(new Point3(_loc11_.position.point.x - 42,_loc11_.position.point.y - 132,1500));
               _loc8_.componentManager.add(_loc8_.position = _loc6_);
               _loc8_.data.townInfoPosition = new Point(_loc6_.point.x + 81,_loc6_.point.y + 38);
               flags.push(_loc8_);
               layers[3].add(_loc8_);
               addChild(_loc8_);
               _loc8_.init();
            }
         }
         else
         {
            doodads.push(_loc12_);
         }
      }
      
      override public function addTile(param1:int, param2:int) : void
      {
         var _loc7_:GameSprite = null;
         var _loc4_:MapTileData = null;
         var _loc5_:int = 0;
         var _loc3_:String = null;
         var _loc6_:MapView = null;
         if(param1 < 18 && param2 < 22 && !tiles[param1][param2])
         {
            _loc7_ = new GameSprite();
            _loc5_ = int(tileLayout[param1][param2]);
            _loc4_ = new MapTileData(_loc5_,null);
            _loc3_ = getAssetName(_loc4_.assetId);
            _loc6_ = new MapView(2,null,_loc3_,_loc4_);
            _loc7_.componentManager.add(_loc7_.view = _loc6_);
            _loc7_.componentManager.add(_loc7_.position = new Position(generateMapPoint(param1,param2,_loc4_.assetId)));
            _loc7_.position.point.z = param1 + (param2 % 2 == 1 ? 0.5 : 0);
            _loc7_.componentManager.add(new CampaignMapProjection());
            tiles[param1][param2] = _loc7_;
         }
      }
      
      override protected function onMouseClick() : void
      {
         var _loc1_:MapTileData = null;
         var _loc2_:GameSprite = userInteract.pickedEntity;
         if(_loc2_)
         {
            _loc1_ = _loc2_.componentManager["MapTileData"];
         }
         if(_loc2_ && _loc1_ && _loc1_.mapMemberInfo)
         {
            eventDispatcher.dispatchEvent(new TownOptionsMenuEvent("triggerWithoutShowing",_loc1_));
         }
      }
      
      override public function generateMapPoint(param1:Number, param2:Number, param3:int = -1) : Point3
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(param2 % 2 == 1)
         {
            param1 += 0.5;
         }
         switch(param3 - 14)
         {
            case 0:
               _loc5_ = 0;
               _loc4_ = -4;
               break;
            case 1:
               _loc5_ = 0;
               _loc4_ = -7;
               break;
            case 2:
               _loc5_ = 0;
               _loc4_ = -20;
               break;
            case 3:
               _loc5_ = 0;
               _loc4_ = -44;
               break;
            case 4:
               _loc5_ = 0;
               _loc4_ = 0;
               break;
            case 5:
               _loc5_ = -1;
               _loc4_ = 0;
               break;
            case 6:
               _loc5_ = -1;
               _loc4_ = -15;
               break;
            case 7:
               _loc5_ = -1;
               _loc4_ = -5;
               break;
            case 8:
               _loc5_ = -1;
               _loc4_ = -29;
               break;
            case 9:
               _loc5_ = -10;
               _loc4_ = -30;
               break;
            case 10:
               _loc5_ = 1;
               _loc4_ = -9;
               break;
            case 11:
               _loc5_ = 0;
               _loc4_ = -4;
               break;
            case 12:
               _loc5_ = -1;
               _loc4_ = -80;
               break;
            case 13:
               _loc5_ = -1;
               _loc4_ = -62;
         }
         return new Point3(-canvasWidth / 2 + param2 * 131 + _loc5_,-canvasHeight / 2 + param1 * 94 + _loc4_);
      }
      
      override public function mapInfoReceived(param1:GetMapInfoResponse) : void
      {
         npcInfos = campaignMapInfo.npcInfos;
         fillMap();
         platformUsersUpdated();
      }
      
      override public function getMapInfoRequest() : void
      {
      }
   }
}

