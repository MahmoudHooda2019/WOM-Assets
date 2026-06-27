package wom.view.ui.mainframe.city.friends.mobile
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import flash.utils.Dictionary;
   import peak.component.mobile.MPList;
   import peak.display.View;
   import starling.display.Sprite;
   import wom.model.game.Thorzain;
   import wom.model.game.friend.FriendInfo;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileFriendsPanel extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _friendsList:MPList;
      
      private var _highlightThorzain:Boolean;
      
      public function MobileFriendsPanel(param1:Boolean)
      {
         super();
         _highlightThorzain = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _friendsList = new MPList();
         _friendsList.itemRendererFactory = friendsPanelFriendViewRendererFactory;
         _friendsList.width = 798;
         _friendsList.height = 526;
         addChild(_friendsList);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _friendsList.x = 30;
         _friendsList.y = 0;
      }
      
      private function friendsPanelFriendViewRendererFactory() : IListItemRenderer
      {
         var _loc1_:FriendsPanelFriendViewRenderer = new FriendsPanelFriendViewRenderer(assetRepository);
         _loc1_.width = 798;
         _loc1_.height = 96;
         return _loc1_;
      }
      
      public function updateFriends(param1:Vector.<FriendInfo>, param2:Dictionary, param3:Dictionary, param4:Vector.<int>) : void
      {
         var _loc5_:ListCollection = new ListCollection();
         for each(var _loc6_ in param1)
         {
            _loc5_.push({
               "friendInfo":_loc6_,
               "giftQuota":_loc6_.profile.gameId in param2,
               "friendWatchPostInfo":param3[_loc6_.profile.gameId],
               "friendWatchPostCapacitiesPerLevel":param4,
               "highlightThorzain":_highlightThorzain && _loc6_.profile == Thorzain.PROFILE
            });
         }
         _friendsList.dataProvider = _loc5_;
         _friendsList.validate();
      }
      
      public function get friendsList() : MPList
      {
         return _friendsList;
      }
   }
}

