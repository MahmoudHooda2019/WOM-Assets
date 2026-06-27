package wom.view.screen.windows.rank.mobile
{
   import feathers.controls.Button;
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPItemRenderer;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import wom.model.game.rank.MobileRankingRow;
   import wom.model.game.rank.RankingRow;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.windows.alliance.coa.mobile.MobileCoatOfArmsView;
   import wom.view.screen.windows.rank.MobileRankView;
   
   public class MobileRankingViewRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      public static const ICON_TYPE_INVALID:int = 0;
      
      public static const ICON_TYPE_BP:int = 1;
      
      public static const ICON_TYPE_XP:int = 2;
      
      public static const ICON_TYPE_LOOT:int = 3;
      
      private static const WIDTH:int = 947;
      
      private static const HEIGHT:int = 96;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var background:DisplayObject;
      
      private var backgroundAssetId:String;
      
      private var rankView:MobileRankView;
      
      private var avatar:DisplayObject;
      
      private var allianceCOA:MobileCoatOfArmsView;
      
      private var starIcon:DisplayObject;
      
      private var levelTF:MPTextField;
      
      private var userNameTF:MPTextField;
      
      private var allianceNameTF:MPTextField;
      
      private var icon:DisplayObject;
      
      private var scoreTF:MPTextField;
      
      private var _enterCityButton:Button;
      
      private var _rankingRow:MobileRankingRow;
      
      private var _ownGameId:String;
      
      public function MobileRankingViewRenderer(param1:MobileWomAssetRepository, param2:String, param3:int)
      {
         super();
         this.assetRepository = param1;
         _ownGameId = param2;
         drawBackground();
         rankView = new MobileRankView(param1);
         addChild(rankView);
         allianceCOA = new MobileCoatOfArmsView(param1);
         addChild(allianceCOA);
         starIcon = param1.getDisplayObject("IconLevelM");
         starIcon.scaleX = starIcon.scaleY = 36 / starIcon.height;
         addChild(starIcon);
         levelTF = new MobileCaptionTextField();
         levelTF.textRendererProperties.textFormat = getCaptionTextFormat(27,"center");
         levelTF.width = starIcon.width;
         addChild(levelTF);
         userNameTF = new MobileCaptionTextField();
         userNameTF.textRendererProperties.textFormat = getCaptionTextFormat(30);
         userNameTF.width = 200;
         addChild(userNameTF);
         allianceNameTF = new MobileWomTextField();
         allianceNameTF.textRendererProperties.textFormat = getWomTextFormat(25);
         allianceNameTF.width = 200;
         addChild(allianceNameTF);
         if(param3 != 0)
         {
            icon = param1.getDisplayObject(param3 == 1 ? "IconBPM" : (param3 == 2 ? "IconLevelM" : "IconStockPileBig"));
            addChild(icon);
         }
         scoreTF = new MobileCaptionTextField();
         scoreTF.textRendererProperties.textFormat = getCaptionTextFormat(30);
         scoreTF.width = 275;
         addChild(scoreTF);
         _enterCityButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         var _temp_12:* = _enterCityButton;
         var _loc5_:String = "ui.mainframe.city.friend.enter";
         _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _enterCityButton.width = 115;
         addChild(_enterCityButton);
      }
      
      private function drawBackground() : void
      {
         var _loc1_:String = _rankingRow == null ? "MobileBeigeBackground" : (_rankingRow.rank == 1 ? "MobileYellowBackground" : (_rankingRow.rank == 2 ? "MobileGrayBackground" : (_rankingRow.rank == 3 ? "MobileBrownBackground" : (_rankingRow && _rankingRow.profile.gameId == _ownGameId ? "MobileGreenBackground" : "MobileBeigeBackground"))));
         var _loc2_:Boolean = false;
         if(background != null)
         {
            if(backgroundAssetId != _loc1_ && contains(background))
            {
               removeChild(background);
               _loc2_ = true;
            }
         }
         else
         {
            _loc2_ = true;
         }
         if(_loc2_)
         {
            background = assetRepository.getDisplayObject(_loc1_);
            background.width = 947;
            background.height = 96;
            addChildAt(background,0);
            backgroundAssetId = _loc1_;
         }
      }
      
      override public function get data() : Object
      {
         return _rankingRow;
      }
      
      override public function set data(param1:Object) : void
      {
         allianceCOA.visible = false;
         allianceNameTF.visible = false;
         if(param1 && param1 is MobileRankingRow)
         {
            _rankingRow = param1 as MobileRankingRow;
            drawBackground();
            if(avatar && contains(avatar))
            {
               removeChild(avatar);
               avatar = null;
            }
            avatar = assetRepository.getAvatarByProfile(_rankingRow.profile);
            addChildAt(avatar,1);
            rankView.updateWithRankInfo(_rankingRow.rank);
            userNameTF.text = _rankingRow.visibleName;
            levelTF.text = _rankingRow.level.toString();
            if(_rankingRow.alliance)
            {
               allianceNameTF.text = _rankingRow.alliance.name;
               allianceCOA.visible = true;
               allianceCOA.updateWithCoatOfArmsInfo(_rankingRow.alliance.coaInfo);
            }
            scoreTF.text = NumberUtil.numberFormat(_rankingRow.score,2,false,false);
         }
         drawLayout();
      }
      
      override public function isInvalid(param1:String = null) : Boolean
      {
         if(_rankingRow && userNameTF.text != _rankingRow.visibleName)
         {
            userNameTF.text = _rankingRow.visibleName;
            return true;
         }
         return super.isInvalid(param1);
      }
      
      public function drawLayout() : void
      {
         levelTF.validate();
         userNameTF.validate();
         allianceNameTF.validate();
         scoreTF.validate();
         _enterCityButton.paddingLeft = 0;
         _enterCityButton.validate();
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(rankView,background,3);
         MobileAlignmentUtil.alignAccordingToPositionOf(avatar,background,117,13);
         MobileAlignmentUtil.alignAccordingToPositionOf(starIcon,avatar,-10,-11);
         MobileAlignmentUtil.alignMiddleOf(levelTF,starIcon);
         levelTF.x -= 3;
         levelTF.y += 5;
         if(allianceCOA.height != 71)
         {
            allianceCOA.scaleX = allianceCOA.scaleY = 71 / allianceCOA.height;
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(allianceCOA,background,194,13);
         MobileAlignmentUtil.alignAccordingToPositionOf(userNameTF,background,277,25);
         MobileAlignmentUtil.alignBelowOf(allianceNameTF,userNameTF,-3);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(scoreTF,background,560);
         if(icon)
         {
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(icon,background,525);
            icon.y -= 3;
         }
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_enterCityButton,background,815);
      }
      
      public function get rankingRow() : RankingRow
      {
         return _rankingRow;
      }
      
      public function get enterCityButton() : Button
      {
         return _enterCityButton;
      }
   }
}

