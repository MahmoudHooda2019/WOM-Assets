package wom.view.ui.tutorial.mobile
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.util.MobileAlignmentUtil;
   import starling.display.Sprite;
   import wom.model.game.tutorial.TutorialAlignmentReferenceType;
   import wom.model.game.tutorial.TutorialInfo;
   import wom.model.game.tutorial.TutorialState;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getWomTextFormat;
   
   public class MobileGenericTutorialWindow extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _backgroundContainer:Sprite;
      
      private var _tutorialGirlAsset:MobileTutorialGirlView;
      
      private var _tutorialDescriptionTextField:MPTextField;
      
      private var _doneButton:MPButton;
      
      private var _doneButtonDefaultLabel:String;
      
      private var _currentState:TutorialState;
      
      public function MobileGenericTutorialWindow()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      protected function initLayout() : void
      {
         _backgroundContainer = new Sprite();
         addChildAt(_backgroundContainer,0);
         _tutorialDescriptionTextField = new MobileWomTextField();
         _tutorialDescriptionTextField.textRendererProperties.textFormat = getWomTextFormat(27,Languages.activeLanguageId == "ar" ? "center" : "left",16777215);
         _tutorialDescriptionTextField.textRendererProperties.wordWrap = true;
         _tutorialDescriptionTextField.width = 250;
         _backgroundContainer.addChild(_tutorialDescriptionTextField);
         var _loc1_:String = "tutorial.done";
         _doneButtonDefaultLabel = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _doneButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _doneButton.visible = false;
         _doneButton.paddingLeft = _doneButton.paddingRight = 20;
         _doneButton.minWidth = 100;
         _doneButton.width = NaN;
         addChild(_doneButton);
      }
      
      public function updateWithTutorialInfo(param1:TutorialInfo) : TutorialState
      {
         var _loc2_:String = null;
         clearWindowComponents();
         if(param1.states.length > 0)
         {
            if(param1.isCompleted)
            {
               log(LoggerContexts.UNEXPECTED,"Completed tutorial is triggered");
            }
            _currentState = param1.states[param1.currentStateIndex];
            if(_currentState.window.enabled)
            {
               _tutorialGirlAsset = new MobileTutorialGirlView(_currentState.window.tutorialGirlAssetType,_currentState.window.flipped);
               _backgroundContainer.addChildAt(_tutorialGirlAsset,0);
               _tutorialDescriptionTextField.textRendererProperties.textFormat = getWomTextFormat(27,Languages.activeLanguageId == "ar" ? "center" : (_currentState.window.flipped ? "right" : "left"),16777215);
               _tutorialDescriptionTextField.text = _currentState.window.textToBeShown;
               if(_currentState.window.doneButton)
               {
                  _loc2_ = "tutorial.step." + _currentState.id + ".done";
                  var _loc3_:String;
                  _doneButton.label = PText.INSTANCE.hasKey(_loc2_) ? (_loc3_ = _loc2_,peak.i18n.PText.INSTANCE.getText0(_loc3_)) : _doneButtonDefaultLabel;
                  _doneButton.validate();
                  _doneButton.visible = true;
               }
               updatePositioning();
               getReferencePosition(_currentState.window.alignmentReference,1,_currentState.additionalInfo);
            }
            return _currentState;
         }
         return null;
      }
      
      public function getReferencePosition(param1:TutorialAlignmentReferenceType, param2:int, param3:Dictionary) : void
      {
         var _loc4_:String = null;
         switch(param1)
         {
            case TutorialAlignmentReferenceType.POP_UP_WINDOW:
               _loc4_ = "getNewestPopUpPosition";
               break;
            case TutorialAlignmentReferenceType.SECONDARY_POP_UP_WINDOW:
               _loc4_ = "getNewestSecondaryPopUpPosition";
               break;
            case TutorialAlignmentReferenceType.RESOURCE_PANEL:
               _loc4_ = "getResourcePanelPosition";
               break;
            case TutorialAlignmentReferenceType.MENU_PANEL:
               _loc4_ = "getMenuPanelPosition";
               break;
            case TutorialAlignmentReferenceType.BUILD_SHOWCASE:
               _loc4_ = "getBuildShowcaseViewPosition";
               break;
            case TutorialAlignmentReferenceType.CENTER_OF_CITY:
               _loc4_ = "getCenterOfCityPosition";
               break;
            case TutorialAlignmentReferenceType.BUILDING:
               _loc4_ = "getBuildingPosition";
               break;
            case TutorialAlignmentReferenceType.BUILDING_PROGRESSBAR:
               _loc4_ = "getBuildingProgressBarPosition";
               break;
            case TutorialAlignmentReferenceType.TOP_LEFT:
               dispatchEventWith("positionReady",false,{
                  "objectToBeAligned":param2,
                  "position":new Point(0,0)
               });
               break;
            case TutorialAlignmentReferenceType.MAP_TOWN:
               _loc4_ = "getMapTownPosition";
               break;
            case TutorialAlignmentReferenceType.MAP_TOWN_OPTIONS_MENU:
               _loc4_ = "getMapTownOptionsMenuPosition";
               break;
            case TutorialAlignmentReferenceType.COMBAT_MERC_DEPLOY_TAB_MERC_VIEW:
               _loc4_ = "getCombatMercDeployTabMercViewPosition";
               break;
            case TutorialAlignmentReferenceType.COMBAT_MENU_PANEL:
               _loc4_ = "getCombatMenuPanelPosition";
               break;
            case TutorialAlignmentReferenceType.INVENTORY_ITEM_VIEW:
               _loc4_ = "getInventoryItemViewPosition";
               break;
            case TutorialAlignmentReferenceType.QUEST_PREVIEW_VIEW:
               _loc4_ = "getQuestPreviewViewPosition";
               break;
            case TutorialAlignmentReferenceType.HIRING_MERC_VIEW:
               _loc4_ = "getHiringMercViewPosition";
               break;
            case TutorialAlignmentReferenceType.WORKER_PANEL:
               _loc4_ = "getWorkerPanelPosition";
               break;
            case TutorialAlignmentReferenceType.PROTECTION_PANEL:
               _loc4_ = "getProtectionPanelPosition";
               break;
            case TutorialAlignmentReferenceType.TOP_RIGHT:
               _loc4_ = "getTopRightPosition";
               break;
            case TutorialAlignmentReferenceType.BOTTOM_LEFT:
               _loc4_ = "getBottomLeftPosition";
               break;
            case TutorialAlignmentReferenceType.BOTTOM_RIGHT:
               _loc4_ = "getBottomRightPosition";
               break;
            case TutorialAlignmentReferenceType.TUTURIAL_DONE_BUTTON:
               _loc4_ = "getTutorialDoneButtonPosition";
               break;
            case TutorialAlignmentReferenceType.RECON_POINTS_BAR:
               _loc4_ = "getReconPointsBarPosition";
               break;
            case TutorialAlignmentReferenceType.CENTER_OF_SCREEN:
               _loc4_ = "getCenterOfScreenPosition";
               break;
            case TutorialAlignmentReferenceType.MENU_PANEL_BUILD_BUTTON:
               _loc4_ = "getMenuPanelBuildButtonPosition";
               break;
            case TutorialAlignmentReferenceType.MENU_PANEL_UPGRADE_BUTTON:
               _loc4_ = "getMenuPanelUpgradeButtonPosition";
               break;
            case TutorialAlignmentReferenceType.MENU_PANEL_WAR_BUTTON:
               _loc4_ = "getMenuPanelWarButtonPosition";
               break;
            case TutorialAlignmentReferenceType.BATTLE_PROGRESS_BAR:
               _loc4_ = "getBattleProgressBarPosition";
               break;
            case TutorialAlignmentReferenceType.MAP_CAMPAIGN_BUTTON:
               _loc4_ = "getMapCampaignButtonPosition";
               break;
            case TutorialAlignmentReferenceType.MANDATORY_ACTION_BUTTON:
               _loc4_ = "getMandatoryActionButtonPosition";
               break;
            case TutorialAlignmentReferenceType.BUY_EXTRA_WORKER:
               _loc4_ = "getBuyExtraWorkerPosition";
               break;
            case TutorialAlignmentReferenceType.SECONDARY_ACTION_BUTTON:
               _loc4_ = "getSecondaryActionButtonPosition";
         }
         if(_loc4_ != null)
         {
            dispatchEventWith("getPosition",false,{
               "actionType":_loc4_,
               "objectToBeAligned":param2,
               "additionalInfo":param3
            });
         }
      }
      
      public function updateWithAlignmentReferencePosition(param1:Point) : void
      {
         this.x += param1.x;
         this.y += param1.y;
      }
      
      private function clearWindowComponents() : void
      {
         _doneButton.visible = false;
         if(_tutorialGirlAsset != null && _backgroundContainer.contains(_tutorialGirlAsset))
         {
            _backgroundContainer.removeChild(_tutorialGirlAsset);
         }
      }
      
      public function updatePositioning() : void
      {
         if(_currentState != null)
         {
            this.x = _currentState.window.position.x;
            this.y = _currentState.window.position.y;
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_tutorialDescriptionTextField,_tutorialGirlAsset.bg,_currentState.window.flipped ? 165 : 55);
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_doneButton,_tutorialGirlAsset.bg,236);
         }
      }
      
      public function get doneButton() : MPButton
      {
         return _doneButton;
      }
   }
}

