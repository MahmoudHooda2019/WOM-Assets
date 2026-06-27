package wom.view.screen.windows.inbox.mobile
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.Sprite;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.screen.windows.report.attacklog.mobile.MobileAttackLogPanel;
   import wom.view.util.MobileButtonTabbedFullscreenWindow;
   
   public class MobileInboxWindow extends MobileButtonTabbedFullscreenWindow
   {
      
      private var _attacksTabButton:MPButton;
      
      private var _defensesTabButton:MPButton;
      
      private var _inboxTabButton:MPButton;
      
      private var _userGameId:String;
      
      public function MobileInboxWindow(param1:String, param2:Vector.<WindowEnumeration> = null)
      {
         super(true,param2);
         _userGameId = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.inbox.inbox";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         var _temp_2:* = this;
         var _loc2_:String = "ui.windows.inbox.attacks";
         _attacksTabButton = createTabButton(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc2_));
         var _temp_5:* = this;
         var _loc3_:String = "ui.windows.inbox.defenses";
         _defensesTabButton = createTabButton(_temp_5,peak.i18n.PText.INSTANCE.getText0(_loc3_));
         var _temp_8:* = this;
         var _loc4_:String = "ui.windows.inbox.inbox";
         _inboxTabButton = createTabButton(_temp_8,peak.i18n.PText.INSTANCE.getText0(_loc4_));
         addTab(this,_attacksTabButton,new MobileAttackLogPanel(_userGameId,true,false,_windowWidth - 24));
         addTab(this,_defensesTabButton,new MobileAttackLogPanel(_userGameId,false,true,_windowWidth - 24));
         addTab(this,_inboxTabButton,new MobileInboxPanel(_windowWidth - 24));
         drawLayout();
         activateTabByButton(_attacksTabButton);
      }
      
      private function drawLayout() : void
      {
         _attacksTabButton.x = 27;
         _attacksTabButton.y = 93;
         MobileAlignmentUtil.alignRightOf(_defensesTabButton,_attacksTabButton,7);
         _inboxTabButton.x = _windowWidth - 30 - _inboxTabButton.width;
         _inboxTabButton.y = _attacksTabButton.y;
      }
      
      override protected function determineTabPosition(param1:Sprite, param2:Object = null, param3:Object = null) : void
      {
         super.determineTabPosition(param1,param2 != null ? param2 : 16,param3 != null ? param3 : 170);
      }
      
      public function get inboxTabButton() : MPButton
      {
         return _inboxTabButton;
      }
   }
}

