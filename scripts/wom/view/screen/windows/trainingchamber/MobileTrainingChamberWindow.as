package wom.view.screen.windows.trainingchamber
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import flash.utils.Dictionary;
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.event.EventItemUtil;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.MobileWomCarousel;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileTrainingChamberWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 831;
      
      private static const WINDOW_HEIGHT:int = 623;
      
      private var _buildingInstanceId:int;
      
      private var _mercenaryList:MobileWomCarousel;
      
      private var maxLevelButton:MPButton;
      
      private var _trainButton:MPButton;
      
      private var _trainNowButton:MobileWomButton;
      
      private var _stopButton:MPButton;
      
      private var _finishNowButton:MobileWomButton;
      
      private var _speedUpButton:MobileWomButton;
      
      private var _activeTrainingUnitTypeIdForThisBuilding:int;
      
      private var _unitIDtoIndexMap:Dictionary;
      
      private var _initialUnitTypeId:int;
      
      private var activeTrainingUnitIds:Array;
      
      private var possibleTrainingUnitId:int;
      
      public function MobileTrainingChamberWindow(param1:int, param2:int = -1, param3:Vector.<WindowEnumeration> = null)
      {
         super(831,623,param3);
         _buildingInstanceId = param1;
         _activeTrainingUnitTypeIdForThisBuilding = -1;
         _initialUnitTypeId = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.trainingchamber.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _mercenaryList = MobileWomUIComponentFactory.createCarousel("horizontal",227,358,516);
         _mercenaryList.itemRendererFactory = trainingChamberRendererFactory;
         _mercenaryList.width = 831 - 34;
         _mercenaryList.height = 516;
         addChild(_mercenaryList);
         maxLevelButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         maxLevelButton.width = 250;
         var _temp_4:* = maxLevelButton;
         var _loc2_:String = "ui.windows.trainingchamber.trainedmax";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         maxLevelButton.isEnabled = false;
         addChild(maxLevelButton);
         _trainButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _trainButton.width = 196;
         _trainButton.label = "train";
         addChild(_trainButton);
         _trainNowButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _trainNowButton.width = 352;
         _trainNowButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         var _temp_7:* = _trainNowButton;
         var _loc3_:String = "ui.windows.trainingchamber.instanttraining";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _trainNowButton.rightLabel = " ";
         addChild(_trainNowButton);
         _stopButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
         _stopButton.width = 109;
         var _temp_9:* = _stopButton;
         var _loc4_:String = "ui.windows.trainingchamber.stop";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         addChild(_stopButton);
         _finishNowButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _finishNowButton.width = 393;
         _finishNowButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         var _temp_11:* = _finishNowButton;
         var _loc5_:String = "ui.windows.constructionsite.finishnowbutton";
         _temp_11.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _finishNowButton.rightLabel = " ";
         addChild(_finishNowButton);
         _speedUpButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _speedUpButton.width = 211;
         _speedUpButton.defaultIcon = assetRepository.getDisplayObject("IconRPM");
         var _temp_13:* = _speedUpButton;
         var _loc6_:String = "ui.windows.constructionsite.cutdurationwithrp";
         _temp_13.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _speedUpButton.rightLabel = "30";
         addChild(_speedUpButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_mercenaryList,_background,41);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(maxLevelButton,_background,623 - 55);
         MobileAlignmentUtil.alignAccordingToPositionOf(_stopButton,_background,48,623 - 44);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_finishNowButton,_stopButton,118);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_speedUpButton,_finishNowButton,403);
         MobileAlignmentUtil.alignAccordingToPositionOf(_trainButton,_background,136,623 - 55);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_trainNowButton,_trainButton,209);
      }
      
      private function trainingChamberRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileTrainingChamberItemViewRenderer = new MobileTrainingChamberItemViewRenderer(assetRepository);
         _loc1_.width = 358;
         _loc1_.height = 516;
         return _loc1_;
      }
      
      public function get mercenaryList() : MobileWomCarousel
      {
         return _mercenaryList;
      }
      
      public function fillUnits(param1:Vector.<UnitTypeDIO>, param2:Dictionary, param3:Vector.<int>, param4:Vector.<EventItemDIO>) : void
      {
         var _loc7_:Boolean = false;
         var _loc5_:UnitTypeInfo = null;
         _unitIDtoIndexMap = new Dictionary();
         activeTrainingUnitIds = [];
         var _loc9_:int = 0;
         var _loc8_:Array = [];
         for each(var _loc6_ in param1)
         {
            _loc5_ = param2[_loc6_.id];
            _unitIDtoIndexMap[_loc6_.id] = _loc9_;
            _loc7_ = _loc6_.event ? EventItemUtil.isUnlocked(_loc6_,_loc5_,param3,param4) : false;
            _loc8_.push({
               "unitTypeDIO":_loc6_,
               "unitTypeInfo":_loc5_,
               "showMercenaryView":true,
               "isEventItemUnlocked":_loc7_
            });
            if(_loc5_.currentlyTraining)
            {
               activeTrainingUnitIds.push(_loc6_.id);
            }
            _loc9_++;
         }
         _mercenaryList.dataProvider = new ListCollection(_loc8_);
         updateFirstPageUnitId(param2,param1);
         updateButtons();
      }
      
      public function updateTrainingUnitProgresses(param1:Dictionary, param2:Vector.<UnitTypeDIO>, param3:Vector.<int>, param4:Vector.<EventItemDIO>) : void
      {
         var _loc7_:Boolean = false;
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         var _loc8_:Boolean = false;
         var _loc5_:UnitTypeInfo = null;
         var _loc6_:UnitTypeDIO = null;
         _loc10_ = 0;
         while(_loc10_ < activeTrainingUnitIds.length)
         {
            _loc9_ = int(_unitIDtoIndexMap[activeTrainingUnitIds[_loc10_]]);
            _loc8_ = Boolean(_mercenaryList.dataProvider.getItemAt(_loc9_).showMercenaryView);
            _loc5_ = param1[activeTrainingUnitIds[_loc10_]];
            _loc6_ = param2[_loc9_];
            _loc7_ = _loc6_.event ? EventItemUtil.isUnlocked(_loc6_,_loc5_,param3,param4) : false;
            _mercenaryList.dataProvider.setItemAt({
               "unitTypeDIO":_loc6_,
               "unitTypeInfo":_loc5_,
               "showMercenaryView":_loc8_,
               "chamberLevel":-1,
               "cityMightAmount":-1,
               "isEventItemUnlocked":_loc7_
            },_loc9_);
            _loc10_++;
         }
      }
      
      public function updateAllUnitViews(param1:Dictionary, param2:Vector.<UnitTypeDIO>, param3:int, param4:Number, param5:Vector.<int>, param6:Vector.<EventItemDIO>) : void
      {
         var _loc9_:Boolean = false;
         var _loc11_:Boolean = false;
         var _loc7_:UnitTypeInfo = null;
         var _loc10_:int = 0;
         activeTrainingUnitIds = [];
         for each(var _loc8_ in param2)
         {
            _loc11_ = Boolean(_mercenaryList.dataProvider.getItemAt(_loc10_).showMercenaryView);
            _loc7_ = param1[_loc8_.id];
            _loc9_ = _loc8_.event ? EventItemUtil.isUnlocked(_loc8_,_loc7_,param5,param6) : false;
            _mercenaryList.dataProvider.setItemAt({
               "unitTypeDIO":_loc8_,
               "unitTypeInfo":_loc7_,
               "showMercenaryView":_loc11_,
               "chamberLevel":param3,
               "cityMightAmount":param4,
               "isEventItemUnlocked":_loc9_
            },_loc10_);
            if(_loc7_.currentlyTraining)
            {
               activeTrainingUnitIds.push(_loc8_.id);
            }
            _loc10_++;
         }
         updateFirstPageUnitId(param1,param2);
         updateButtons();
      }
      
      private function updateFirstPageUnitId(param1:Dictionary, param2:Vector.<UnitTypeDIO>) : void
      {
         var _loc4_:* = null;
         var _loc5_:UnitTypeInfo = null;
         for each(_loc4_ in param2)
         {
            _loc5_ = param1[_loc4_.id];
            if(!_loc5_.currentlyTraining && _loc5_.recruited && !_loc5_.currentlyRecruiting)
            {
               possibleTrainingUnitId = _loc5_.unitTypeId;
               break;
            }
         }
         var _loc3_:int = 0;
         for each(_loc4_ in param2)
         {
            _loc5_ = param1[_loc4_.id];
            if(!_loc5_.currentlyTraining && _loc5_.recruited && !_loc5_.currentlyRecruiting)
            {
               if(_mercenaryList.dataProvider.getItemAt(_unitIDtoIndexMap[_initialUnitTypeId]).unitTypeInfo.currentLevel > _loc5_.currentLevel)
               {
                  possibleTrainingUnitId = _loc5_.unitTypeId;
               }
            }
            _loc3_++;
         }
      }
      
      public function updateButtons(param1:Boolean = false) : void
      {
         var _loc4_:UnitTypeInfo = selectedUnitTypeInfo;
         var _loc2_:UnitTypeDIO = selectedUnitTypeDIO;
         if(param1)
         {
            maxLevelButton.visible = _trainButton.visible = _trainNowButton.visible = _stopButton.visible = _finishNowButton.visible = _speedUpButton.visible = false;
         }
         else
         {
            _stopButton.visible = _loc4_.currentlyTraining;
            maxLevelButton.visible = _loc4_.currentLevel == _loc2_.maxLevels;
            _trainButton.visible = _trainNowButton.visible = !_loc4_.currentlyTraining && _loc4_.currentLevel != _loc2_.maxLevels;
            _stopButton.visible = _finishNowButton.visible = _speedUpButton.visible = _loc4_.currentlyTraining;
         }
         var _loc3_:int = int(_loc4_.currentLevel == _loc2_.maxLevels ? _loc4_.currentLevel - 1 : _loc4_.currentLevel);
         var _loc5_:Number = _loc4_.jobCreationTime + _loc4_.durationRemaining - new Date().getTime();
         _trainNowButton.rightLabel = StoreUtil.mercenaryTrainAndRecruitPrice(_loc2_.trainingCostsPerLevel[_loc3_][0].resourceAmount,_loc2_.trainingDurationPerLevelInSecs[_loc3_]) + "";
         var _loc7_:String;
         _finishNowButton.rightLabel = _loc4_.durationRemaining < 300000 ? (_loc7_ = "ui.windows.constructionsite.free",peak.i18n.PText.INSTANCE.getText0(_loc7_)) : StoreUtil.mercenaryTrainAndRecruitPrice(0,_loc5_ / 1000) + "";
         _stopButton.isEnabled = _speedUpButton.isEnabled = _finishNowButton.isEnabled = _activeTrainingUnitTypeIdForThisBuilding == selectedUnitTypeDIO.id;
      }
      
      public function get trainButton() : MPButton
      {
         return _trainButton;
      }
      
      public function get trainNowButton() : MobileWomButton
      {
         return _trainNowButton;
      }
      
      public function get stopButton() : MPButton
      {
         return _stopButton;
      }
      
      public function get finishNowButton() : MobileWomButton
      {
         return _finishNowButton;
      }
      
      public function get speedUpButton() : MobileWomButton
      {
         return _speedUpButton;
      }
      
      public function get selectedUnitTypeInfo() : UnitTypeInfo
      {
         return _mercenaryList.dataProvider.getItemAt(_mercenaryList.selectedPageIndex).unitTypeInfo;
      }
      
      public function get selectedUnitTypeDIO() : UnitTypeDIO
      {
         return _mercenaryList.dataProvider.getItemAt(_mercenaryList.selectedPageIndex).unitTypeDIO;
      }
      
      public function get buildingInstanceId() : int
      {
         return _buildingInstanceId;
      }
      
      public function get activeTrainingUnitTypeIdForThisBuilding() : int
      {
         return _activeTrainingUnitTypeIdForThisBuilding;
      }
      
      public function set activeTrainingUnitTypeIdForThisBuilding(param1:int) : void
      {
         _activeTrainingUnitTypeIdForThisBuilding = param1;
      }
      
      public function scrollToRequiredPage() : void
      {
         if(_activeTrainingUnitTypeIdForThisBuilding != -1)
         {
            _mercenaryList.scrollToPageIndex(_unitIDtoIndexMap[_activeTrainingUnitTypeIdForThisBuilding],0,0);
         }
         else if(_initialUnitTypeId != -1)
         {
            _mercenaryList.scrollToPageIndex(_unitIDtoIndexMap[_initialUnitTypeId],0,0);
         }
         else
         {
            _mercenaryList.scrollToPageIndex(_unitIDtoIndexMap[possibleTrainingUnitId],0,0);
         }
         updateButtons();
      }
   }
}

