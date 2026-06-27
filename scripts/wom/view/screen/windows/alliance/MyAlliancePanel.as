package wom.view.screen.windows.alliance
{
   import fl.controls.Button;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.view.component.button.colored.WomBrownSmallButton;
   import wom.view.util.BaseWindowPanel;
   
   public class MyAlliancePanel extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 665;
      
      private static const GENERAL_INFO_HEIGHT:int = 412;
      
      private static const MEMBERS_HEIGHT:int = 443;
      
      private var _generalInfoButton:Button;
      
      private var _membersButton:Button;
      
      private var _generalInfoPanel:AllianceGeneralInfoPanel;
      
      private var _membersPanel:MyAllianceMembersPanel;
      
      private var _editPanel:CreateAlliancePanel;
      
      public function MyAlliancePanel()
      {
         super(665,412);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _generalInfoButton = new WomBrownSmallButton();
         _generalInfoButton.width = 130;
         _generalInfoButton.toggle = true;
         var _temp_2:* = _generalInfoButton;
         var _loc1_:String = "ui.windows.alliance.myalliance.generalinfo";
         _temp_2.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _generalInfoButton.selected = true;
         _generalInfoButton.mouseEnabled = false;
         addChild(_generalInfoButton);
         _membersButton = new WomBrownSmallButton();
         _membersButton.width = 102;
         _membersButton.toggle = true;
         var _temp_4:* = _membersButton;
         var _loc2_:String = "ui.windows.alliance.myalliance.membersbutton";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_membersButton);
         _generalInfoPanel = new AllianceGeneralInfoPanel();
         addChild(_generalInfoPanel);
         _membersPanel = new MyAllianceMembersPanel();
         _membersPanel.visible = false;
         addChild(_membersPanel);
         _editPanel = null;
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_generalInfoButton,bg,11,11);
         AlignmentUtil.alignAccordingToPositionOf(_membersButton,bg,145,11);
         AlignmentUtil.alignAccordingToPositionOf(_generalInfoPanel,bg,0,46);
         AlignmentUtil.alignAccordingToPositionOf(_membersPanel,bg,2,46);
         super.drawLayout();
      }
      
      public function updatePanelHeight() : void
      {
         super.updateBackground(665,_generalInfoPanel.visible ? 412 : 443);
      }
      
      public function updateVisibilityOfEditPanel(param1:Boolean) : void
      {
         if(_editPanel == null)
         {
            if(param1)
            {
               _editPanel = new CreateAlliancePanel(true);
               _editPanel.visible = true;
               addChild(_editPanel);
            }
         }
         else
         {
            _editPanel.visible = param1;
         }
      }
      
      public function get generalInfoButton() : Button
      {
         return _generalInfoButton;
      }
      
      public function get membersButton() : Button
      {
         return _membersButton;
      }
      
      public function get generalInfoPanel() : AllianceGeneralInfoPanel
      {
         return _generalInfoPanel;
      }
      
      public function get membersPanel() : MyAllianceMembersPanel
      {
         return _membersPanel;
      }
      
      public function get editPanel() : CreateAlliancePanel
      {
         return _editPanel;
      }
   }
}

