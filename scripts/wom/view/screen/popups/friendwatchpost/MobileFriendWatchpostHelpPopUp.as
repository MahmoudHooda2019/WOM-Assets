package wom.view.screen.popups.friendwatchpost
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import wom.model.game.watchpost.WatchpostHelpInfo;
   import wom.model.game.watchpost.WatchpostHelpedFriendDTO;
   import wom.view.screen.popups.help.MobileHelpedFriendPopUp;
   
   public class MobileFriendWatchpostHelpPopUp extends MobileHelpedFriendPopUp
   {
      
      public function MobileFriendWatchpostHelpPopUp(param1:WatchpostHelpInfo)
      {
         super(param1);
      }
      
      override public function get numOfHelps() : int
      {
         return (_helps as WatchpostHelpInfo).helpedFriends.length;
      }
      
      override protected function fillPane() : void
      {
         var _loc1_:Array = [];
         for each(var _loc2_ in (_helps as WatchpostHelpInfo).helpedFriends)
         {
            _loc1_.push({"friendHelp":_loc2_});
         }
         _list.dataProvider = new ListCollection(_loc1_);
         _list.validate();
      }
      
      override protected function factory() : IListItemRenderer
      {
         var _loc1_:MobileFriendWatchpostHelpLineRenderer = new MobileFriendWatchpostHelpLineRenderer(assetRepository,facebookAPIManager);
         _loc1_.width = 480;
         _loc1_.height = 75;
         return _loc1_;
      }
   }
}

