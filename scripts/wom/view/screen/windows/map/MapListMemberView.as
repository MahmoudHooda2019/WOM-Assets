package wom.view.screen.windows.map
{
   import fl.controls.Button;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.component.attribute.data.MapTileData;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomRedSmallButton;
   import wom.view.screen.windows.alliance.coa.CoatOfArmsView;
   import wom.view.ui.common.IconLabelView;
   import wom.view.util.LineUtil;
   
   public class MapListMemberView extends Sprite implements View
   {
      
      private static var backgroundBitmapData:BitmapData;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _tileData:MapTileData;
      
      private var _lastVisibleRow:Boolean;
      
      public var enterButton:Button;
      
      private var levelIndicator:DisplayObject;
      
      private var avatar:DisplayObject;
      
      private var _coatOfArmsView:CoatOfArmsView;
      
      private var _nameTextField:CaptionTextField;
      
      private var _allianceNameTextField:WomTextField;
      
      private var levelTextField:CaptionTextField;
      
      private var bpView:IconLabelView;
      
      private var historyTextField:WomTextField;
      
      private var diplomacyTextField:WomTextField;
      
      private var background:DisplayObject;
      
      public var buttonWidth:int = 70;
      
      public var userLevel:int;
      
      public function MapListMemberView(param1:int, param2:MapTileData, param3:Boolean = false)
      {
         super();
         this.userLevel = param1;
         _lastVisibleRow = param3;
         _tileData = param2;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc5_:int = 69;
         var _loc3_:int = 31;
         var _loc2_:int = 50;
         var _loc4_:int = 25;
         if(!backgroundBitmapData)
         {
            backgroundBitmapData = new BitmapData(716 - 6,_loc5_,false,13942389);
         }
         background = new Bitmap(backgroundBitmapData);
         background.visible = false;
         addChild(background);
         LineUtil.drawHorizontalSeparatorLine(this,2,714);
         levelIndicator = assetRepository.getDisplayObject("Level");
         avatar = assetRepository.getAvatarByProfile(tileData.mapMemberInfo.profile);
         if(tileData.tileType == 1)
         {
            avatar.width = _loc2_;
            avatar.height = _loc2_;
         }
         levelIndicator.width = _loc4_;
         levelIndicator.height = _loc4_;
         addChild(avatar);
         addChild(levelIndicator);
         _coatOfArmsView = null;
         if(_tileData.mapMemberInfo.alliance)
         {
            _coatOfArmsView = new CoatOfArmsView(assetRepository);
            _coatOfArmsView.updateWithCoatOfArmsInfo(_tileData.mapMemberInfo.alliance.coaInfo);
            addChild(_coatOfArmsView);
         }
         levelTextField = new CaptionTextField();
         levelTextField.width = _loc4_;
         levelTextField.height = _loc4_;
         levelTextField.defaultTextFormat = WomTextFormats.CENTER_18;
         levelTextField.text = "" + tileData.mapMemberInfo.level;
         addChild(levelTextField);
         bpView = new IconLabelView("CrownIcon",_tileData.mapMemberInfo.battlePoints + "",-1);
         bpView.align = "left";
         bpView.visible = !_tileData.mapMemberInfo.profile.isNpc;
         addChild(bpView);
         _nameTextField = new CaptionTextField();
         _nameTextField.autoSize = "left";
         _nameTextField.width = 113;
         _nameTextField.wordWrap = true;
         _nameTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         _nameTextField.text = tileData.mapMemberInfo.profile.gameId;
         addChild(_nameTextField);
         _allianceNameTextField = new WomTextField();
         _allianceNameTextField.autoSize = "left";
         _allianceNameTextField.width = 113;
         _allianceNameTextField.wordWrap = true;
         _allianceNameTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         _allianceNameTextField.text = tileData.mapMemberInfo.alliance != null ? tileData.mapMemberInfo.alliance.name : "";
         addChild(_allianceNameTextField);
         historyTextField = new WomTextField();
         historyTextField.width = 86;
         historyTextField.defaultTextFormat = WomTextFormats.CENTER_18;
         historyTextField.wordWrap = true;
         historyTextField.height = 100;
         if(tileData.mapMemberInfo.numberOfBattles >= 1)
         {
            historyTextField.textColor = 16711680;
         }
         if(tileData.mapMemberInfo.profile.isNpc)
         {
            historyTextField.text = "";
         }
         else
         {
            historyTextField.text = tileData.mapMemberInfo.numberOfWins + "/" + tileData.mapMemberInfo.numberOfBattles;
         }
         addChild(historyTextField);
         diplomacyTextField = new WomTextField();
         diplomacyTextField.width = 106;
         diplomacyTextField.wordWrap = true;
         diplomacyTextField.height = 100;
         var _loc1_:int = 0;
         var _loc7_:String = "ui.windows.map.neutral";
         var _loc6_:String = peak.i18n.PText.INSTANCE.getText0(_loc7_) + " ";
         if(tileData.mapMemberInfo.playerRelation == 8)
         {
            _loc1_ = 255;
            var _loc8_:String = "ui.windows.map.wipedout";
            _loc6_ = peak.i18n.PText.INSTANCE.getText0(_loc8_) + " ";
         }
         else if(tileData.mapMemberInfo.playerRelation == 2)
         {
            if(_tileData.mapMemberInfo.isRevanchist)
            {
               _loc1_ = 16711680;
               var _loc9_:String = "ui.windows.map.revanchist";
               _loc6_ = peak.i18n.PText.INSTANCE.getText0(_loc9_) + " ";
            }
            else if(_tileData.mapMemberInfo.isAllianceEnemy)
            {
               _loc1_ = 16711680;
               var _loc10_:String = "ui.windows.map.allianceenemy";
               _loc6_ = peak.i18n.PText.INSTANCE.getText0(_loc10_) + " ";
            }
            else
            {
               _loc1_ = 16711680;
               var _loc11_:String = "ui.windows.map.hostile";
               _loc6_ = peak.i18n.PText.INSTANCE.getText0(_loc11_) + " ";
            }
         }
         else if(tileData.mapMemberInfo.playerRelation == 6)
         {
            _loc1_ = 255;
            var _loc12_:String = "ui.windows.map.leveltoolow";
            _loc6_ = peak.i18n.PText.INSTANCE.getText0(_loc12_) + " ";
         }
         else if(tileData.mapMemberInfo.playerRelation == 10)
         {
            _loc1_ = 255;
            var _loc13_:String = "ui.windows.map.leveltoohigh";
            _loc6_ = peak.i18n.PText.INSTANCE.getText0(_loc13_) + " ";
         }
         else if(tileData.mapMemberInfo.playerRelation == 7)
         {
            _loc1_ = 255;
            var _loc14_:String = "ui.windows.map.underprotection";
            _loc6_ = peak.i18n.PText.INSTANCE.getText0(_loc14_) + " ";
         }
         else if(tileData.mapMemberInfo.playerRelation == 9)
         {
            _loc1_ = 255;
            var _loc15_:String = "ui.windows.map.ally";
            _loc6_ = peak.i18n.PText.INSTANCE.getText0(_loc15_) + " ";
         }
         else if(_tileData.mapMemberInfo.isRevanchist)
         {
            _loc1_ = 16711680;
            var _loc16_:String = "ui.windows.map.revanchist";
            _loc6_ = peak.i18n.PText.INSTANCE.getText0(_loc16_) + " ";
         }
         else if(_tileData.mapMemberInfo.isAllianceEnemy)
         {
            _loc1_ = 16711680;
            var _loc17_:String = "ui.windows.map.allianceenemy";
            _loc6_ = peak.i18n.PText.INSTANCE.getText0(_loc17_) + " ";
         }
         diplomacyTextField.defaultTextFormat = WomTextFormats.CENTER_18;
         diplomacyTextField.textColor = _loc1_;
         diplomacyTextField.text = _loc6_;
         addChild(diplomacyTextField);
         enterButton = new WomRedSmallButton();
         enterButton.width = 63;
         var _temp_14:* = enterButton;
         var _loc18_:String = "ui.mainframe.city.friend.enter";
         _temp_14.label = peak.i18n.PText.INSTANCE.getText0(_loc18_);
         enterButton.height = _loc3_;
         addChild(enterButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 1;
         var _loc3_:int = 1;
         var _loc2_:int = 23;
         background.x = 3;
         background.y = 0;
         var _loc4_:int = 2;
         AlignmentUtil.alignAccordingToPositionOf(avatar,background,20,10);
         AlignmentUtil.alignAccordingToPositionOf(levelIndicator,avatar,-7,-6);
         AlignmentUtil.alignMiddleOf(levelTextField,levelIndicator);
         _loc4_ += 74 + _loc3_;
         if(_coatOfArmsView)
         {
            AlignmentUtil.alignRightOf(_coatOfArmsView,avatar,20);
         }
         _loc4_ += 82 + _loc3_;
         AlignmentUtil.alignAccordingToPositionOf(_nameTextField,background,_loc4_,_allianceNameTextField.text != "" ? _loc2_ - 6 : _loc2_);
         AlignmentUtil.alignAccordingToPositionOf(_allianceNameTextField,background,_loc4_,_loc2_ + 15);
         _loc4_ += 113 + _loc3_;
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(bpView,background,_loc4_ + (83 >> 1) - (bpView.width >> 1));
         _loc4_ += 83 + _loc3_;
         AlignmentUtil.alignAccordingToPositionOf(historyTextField,background,_loc4_,_loc2_);
         _loc4_ += 86 + _loc3_;
         AlignmentUtil.alignAccordingToPositionOf(diplomacyTextField,background,_loc4_,_loc2_);
         _loc4_ += 106 + _loc3_;
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(enterButton,background,_loc4_ + 15);
         _loc4_ += enterButton.width + _loc1_ + 10;
      }
      
      public function get tileData() : MapTileData
      {
         return _tileData;
      }
      
      public function updateNameField(param1:String) : void
      {
         _nameTextField.text = param1;
      }
      
      public function updateRowBGColor(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         if(_tileData.mapMemberInfo.isEventNpc || _tileData.mapMemberInfo.isFriend || _tileData.mapMemberInfo.isAllianceEnemy || _tileData.mapMemberInfo.isRevanchist || param1)
         {
            _loc2_ = determineColor(param1);
            graphics.lineStyle(0,_loc2_,1,true);
            graphics.beginFill(_loc2_,1);
            if(_lastVisibleRow)
            {
               graphics.drawRoundRectComplex(1,1,713,62,0,0,8,8);
            }
            else
            {
               graphics.drawRect(1,1,713,67);
            }
         }
      }
      
      private function determineColor(param1:Boolean) : int
      {
         return _tileData.mapMemberInfo.isRevanchist ? 13270380 : (_tileData.mapMemberInfo.isAllianceEnemy ? 13270380 : (param1 ? 12838645 : (_tileData.mapMemberInfo.isEventNpc ? 13611231 : 11193156)));
      }
   }
}

