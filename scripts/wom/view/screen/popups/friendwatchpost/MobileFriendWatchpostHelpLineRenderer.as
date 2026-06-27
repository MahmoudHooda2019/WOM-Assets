package wom.view.screen.popups.friendwatchpost
{
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.watchpost.WatchpostHelpedFriendDTO;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.component.MobileWomTextField;
   import wom.view.getWomTextFormat;
   import wom.view.screen.popups.help.MobileHelpedFriendLineRenderer;
   
   public class MobileFriendWatchpostHelpLineRenderer extends MobileHelpedFriendLineRenderer
   {
      
      private var _helpedFriendDTO:WatchpostHelpedFriendDTO;
      
      private var _unitId:Object;
      
      public function MobileFriendWatchpostHelpLineRenderer(param1:MobileWomAssetRepository, param2:FacebookAPIManager)
      {
         super(param1,param2);
      }
      
      override protected function determineDescription() : String
      {
         var _temp_2:* = "ui.popups.helpedfriend.type.7";
         var _temp_1:* = _helpedFriendDTO.helpedUnits[_unitId];
         var _loc1_:String = "domain.units." + _unitId + ".name";
         var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc3_:* = _temp_1;
         var _loc4_:String = _temp_2;
         return peak.i18n.PText.INSTANCE.getText2(_loc4_,_loc3_,_loc2_);
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            _helpedFriendDTO = param1.friendHelp;
         }
         super.data = param1;
      }
      
      override protected function populateHelpViews(param1:int) : int
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:MPTextField = null;
         for(var _loc4_ in _helpedFriendDTO.helpedUnits)
         {
            _unitId = _loc4_;
            _loc2_ = _assetRepository.getDisplayObject("SymbolTickDisable");
            addChild(_loc2_);
            _loc3_ = new MobileWomTextField();
            _loc3_.textRendererProperties.textFormat = Languages.activeLanguageId == "ar" ? getWomTextFormat(17,"right") : getWomTextFormat(25);
            _loc3_.width = 400;
            _loc3_.textRendererProperties.wordWrap = true;
            addChild(_loc3_);
            _loc3_.text = determineDescription();
            MobileAlignmentUtil.alignAccordingToPositionOf(_loc2_,_background,25,0);
            _loc2_.y = param1;
            MobileAlignmentUtil.alignRightOf(_loc3_,_loc2_,12);
            _loc3_.validate();
            param1 += Math.max(_loc2_.height,_loc3_.height) + 5;
         }
         return param1;
      }
      
      override protected function platformUsersUpdated() : void
      {
         _nameCaption.text = _facebookAPIManager.getUserNameByProfile(_helpedFriendDTO.friendProfile,false);
         _nameCaption.validate();
      }
   }
}

