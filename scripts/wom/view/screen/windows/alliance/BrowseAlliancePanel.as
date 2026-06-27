package wom.view.screen.windows.alliance
{
   import fl.controls.Button;
   import flash.text.TextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.logging.log;
   import peak.util.AlignmentUtil;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomBrownSmallButton;
   import wom.view.util.BaseWindowPanel;
   
   public class BrowseAlliancePanel extends BaseWindowPanel implements View
   {
      
      private var _listPanel:BrowseAllianceListPanel;
      
      private var _membersPanel:BrowseAllianceMembersPanel;
      
      private var _generalInfoPanel:AllianceGeneralInfoPanel;
      
      private var _createAlliancepanel:CreateAlliancePanel;
      
      private var _generalInfoButton:Button;
      
      private var _membersButton:Button;
      
      private var _backToAlliancesButton:Button;
      
      private var _allianceNameTextField:TextField;
      
      private var _allianceToBeViewed:AllianceDetailInfo;
      
      public function BrowseAlliancePanel()
      {
         super(665,443);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _listPanel = new BrowseAllianceListPanel();
         addChild(_listPanel);
         _membersPanel = new BrowseAllianceMembersPanel();
         _membersPanel.visible = false;
         addChild(_membersPanel);
         _generalInfoPanel = new AllianceGeneralInfoPanel(true);
         _generalInfoPanel.visible = false;
         addChild(_generalInfoPanel);
         _generalInfoButton = new WomBrownSmallButton();
         _generalInfoButton.width = 130;
         _generalInfoButton.toggle = true;
         var _temp_5:* = _generalInfoButton;
         var _loc1_:String = "ui.windows.alliance.myalliance.generalinfo";
         _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _generalInfoButton.selected = true;
         _generalInfoButton.mouseEnabled = false;
         _generalInfoButton.visible = false;
         addChild(_generalInfoButton);
         _membersButton = new WomBrownSmallButton();
         _membersButton.width = 102;
         _membersButton.toggle = true;
         _membersButton.visible = false;
         var _temp_7:* = _membersButton;
         var _loc2_:String = "ui.windows.alliance.myalliance.membersbutton";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_membersButton);
         _backToAlliancesButton = new WomBrownSmallButton();
         _backToAlliancesButton.width = 152;
         var _temp_9:* = _backToAlliancesButton;
         var _loc3_:String = "ui.windows.alliance.browse.backtoalliances";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _backToAlliancesButton.visible = false;
         addChild(_backToAlliancesButton);
         _allianceNameTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER_SOFT);
         _allianceNameTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_24;
         _allianceNameTextField.autoSize = "left";
         _allianceNameTextField.visible = false;
         addChild(_allianceNameTextField);
         _allianceNameTextField.text = " ";
         _createAlliancepanel = null;
         drawLayout();
      }
      
      public function updateVisibilityOfCreateAlliancePanel(param1:Boolean) : void
      {
         if(_createAlliancepanel == null)
         {
            if(param1)
            {
               _createAlliancepanel = new CreateAlliancePanel(false);
               _createAlliancepanel.visible = true;
               addChild(_createAlliancepanel);
            }
         }
         else
         {
            _createAlliancepanel.visible = param1;
         }
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         AlignmentUtil.alignAccordingToPositionOf(_backToAlliancesButton,_membersPanel,504,10);
         AlignmentUtil.alignAccordingToPositionOf(_generalInfoButton,_membersPanel,11,11);
         AlignmentUtil.alignAccordingToPositionOf(_membersButton,_membersPanel,145,11);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_allianceNameTextField,_membersButton,115);
         AlignmentUtil.alignAccordingToPositionOf(_generalInfoPanel,_membersPanel,0,46);
      }
      
      public function updatePanelsVisibility(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         updateVisibilityOfCreateAlliancePanel(param3);
         _listPanel.visible = param4;
         if(param1 || param2)
         {
            _backToAlliancesButton.visible = true;
            _generalInfoButton.visible = true;
            _membersButton.visible = true;
            if(param1)
            {
               _generalInfoPanel.visible = true;
               _membersPanel.visible = false;
               _generalInfoButton.mouseEnabled = false;
               _membersButton.mouseEnabled = true;
               _membersButton.selected = false;
            }
            else if(param2)
            {
               _generalInfoPanel.visible = false;
               _membersPanel.visible = true;
               _generalInfoButton.mouseEnabled = true;
               _generalInfoButton.selected = false;
               _membersButton.mouseEnabled = false;
            }
            else
            {
               log(WomLoggerContexts.GAME,"Browse alliance detail, both members and general info can not be visible");
            }
         }
         else
         {
            _generalInfoPanel.visible = false;
            _membersPanel.visible = false;
            _backToAlliancesButton.visible = false;
            _generalInfoButton.visible = false;
            _membersButton.visible = false;
            _allianceNameTextField.visible = false;
            updateViewedAlliance(null);
         }
      }
      
      public function updateViewedAlliance(param1:AllianceDetailInfo) : void
      {
         _allianceToBeViewed = param1;
         _allianceNameTextField.text = param1 ? param1.name : "";
         _membersPanel.update(param1);
      }
      
      public function get listPanel() : BrowseAllianceListPanel
      {
         return _listPanel;
      }
      
      public function get membersPanel() : BrowseAllianceMembersPanel
      {
         return _membersPanel;
      }
      
      public function get createAlliancepanel() : CreateAlliancePanel
      {
         return _createAlliancepanel;
      }
      
      public function get generalInfoPanel() : AllianceGeneralInfoPanel
      {
         return _generalInfoPanel;
      }
      
      public function get generalInfoButton() : Button
      {
         return _generalInfoButton;
      }
      
      public function get membersButton() : Button
      {
         return _membersButton;
      }
      
      public function get allianceToBeViewed() : AllianceDetailInfo
      {
         return _allianceToBeViewed;
      }
      
      public function get backToAlliancesButton() : Button
      {
         return _backToAlliancesButton;
      }
   }
}

