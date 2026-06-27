package wom.controller.command.tutorial
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import peak.i18n.PText;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import wom.controller.PCommand;
   import wom.controller.event.tutorial.TutorialEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.ABMode;
   import wom.model.game.UserInfo;
   import wom.model.game.tutorial.TutorialAlignmentReferenceType;
   import wom.model.game.tutorial.TutorialArrowDirection;
   import wom.model.game.tutorial.TutorialInfo;
   import wom.model.game.tutorial.TutorialMask;
   import wom.model.game.tutorial.TutorialPointedArea;
   import wom.model.game.tutorial.TutorialPointedAreaShape;
   import wom.model.game.tutorial.TutorialState;
   import wom.model.game.tutorial.TutorialWindow;
   import wom.model.resource.asset.TutorialGirlAssetType;
   import wom.view.ui.tutorial.mobile.MobileTutorialMaskContainer;
   
   public class MobileCreateTutorialsCommand extends PCommand
   {
      
      [Inject]
      public var event:TutorialEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function MobileCreateTutorialsCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         log(LoggerContexts.INFRASTRUCTURE,"Tutorials will be created");
         if(!(documentConfiguration.hasParameter("disabletutorials") && documentConfiguration.getParameter("disabletutorials")))
         {
            createTutorialInfos();
         }
      }
      
      private function createTutorialInfos() : void
      {
         var _loc1_:TutorialInfo = null;
         userInfo.tutorialsInfo.enabled = true;
         _loc1_ = createTutorialArchersTower();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         if(userInfo.abModeTutorial != ABMode.MODE_B)
         {
            _loc1_ = createTutorialNpcDefense();
            userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         }
         _loc1_ = createTutorialNpcRevenge();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         _loc1_ = createTutorialLumberBlade();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         _loc1_ = createTutorialExtraWorker();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         _loc1_ = createTutorialHiringQuarters();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         _loc1_ = createTutorialHireBedouinBrutes();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         _loc1_ = createTutorialProtectionFlag();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         _loc1_ = createTutorialHelpThorzain();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         _loc1_ = createTutorialRPExplanationTypeStore();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         _loc1_ = createTutorialRPExplanationTypeGainRP();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         _loc1_ = createTutorialFirstAttack();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         _loc1_ = createTutorialFirstRepair();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         _loc1_ = createTutorialResourceFull();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         _loc1_ = createTutorialFirstLooter();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         _loc1_ = createTutorialExplainPartFromActivateBuilding();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         _loc1_ = createTutorialExplainPartFromHireWorker();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         _loc1_ = createTutorialExplainMaps();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         _loc1_ = createTutorialFirstPvP();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
         _loc1_ = createTutorialFirstTank();
         userInfo.tutorialsInfo.tutorials[_loc1_.tutorialId] = _loc1_;
      }
      
      private function createTutorialArchersTower() : TutorialInfo
      {
         var _loc3_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("twr",userInfo.abModeTutorial == ABMode.MODE_B ? "rev" : "def");
         var _loc4_:String;
         var _loc5_:String;
         _loc3_ = userInfo.abModeTutorial == ABMode.MODE_B ? (_loc4_ = "tutorial.step.1b.desc",peak.i18n.PText.INSTANCE.getText0(_loc4_)) : (_loc5_ = "tutorial.step.1.desc",peak.i18n.PText.INSTANCE.getText0(_loc5_));
         _loc2_ = createTutorialState("1",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.BOTTOM_LEFT,new Point(90,-380),true,true),null,null,true);
         _loc2_.additionalInfo["questId"] = 10;
         _loc1_.states.push(_loc2_);
         var _loc6_:String = "tutorial.step.2.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _loc2_ = createTutorialState("2",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.MENU_PANEL_BUILD_BUTTON,new Point(100,-275),false),new TutorialPointedArea(true,TutorialAlignmentReferenceType.MENU_PANEL_BUILD_BUTTON,MobileTutorialMaskContainer.NON_SIZED_RECTANGLE,TutorialArrowDirection.RIGHT,TutorialPointedAreaShape.NONE),null,false);
         _loc2_.additionalInfo["tabBarIndex"] = 2;
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("3",null,new TutorialPointedArea(true,TutorialAlignmentReferenceType.BUILD_SHOWCASE,new Rectangle(0,0,280,257),TutorialArrowDirection.RIGHT,TutorialPointedAreaShape.ROUND_RECT),null,false);
         _loc2_.additionalInfo["buildingTypeId"] = 31;
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("4",null,new TutorialPointedArea(true,TutorialAlignmentReferenceType.MANDATORY_ACTION_BUTTON,MobileTutorialMaskContainer.NON_SIZED_RECTANGLE,TutorialArrowDirection.LEFT,TutorialPointedAreaShape.NONE),null,false);
         _loc1_.states.push(_loc2_);
         var _loc7_:String = "tutorial.step.5.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         _loc2_ = createTutorialState("5",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.BOTTOM_RIGHT,new Point(-500,-300)),null,TutorialMask.NON_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         var _loc8_:String;
         var _loc9_:String;
         _loc3_ = userInfo.abModeTutorial == ABMode.MODE_B ? (_loc8_ = "m.tutorial.step.6b.desc",peak.i18n.PText.INSTANCE.getText0(_loc8_)) : (_loc9_ = "tutorial.step.6.desc",peak.i18n.PText.INSTANCE.getText0(_loc9_));
         _loc2_ = createTutorialState("6",userInfo.abModeTutorial == ABMode.MODE_B ? new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.BOTTOM_RIGHT,new Point(-500,-300)) : null,null,TutorialMask.NON_VISIBLE,false);
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("7",null,null,null,false);
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("8",null,null,null,true);
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialNpcDefense() : TutorialInfo
      {
         var _loc3_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("def","rev");
         var _loc4_:String = "tutorial.step.9.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _loc2_ = createTutorialState("9",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.CENTER_OF_SCREEN,new Point(-236,-140),false,true),null,TutorialMask.BARELY_VISIBLE,false);
         _loc2_.additionalInfo["questId"] = 20;
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("-1",null,null,TutorialMask.NON_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialNpcRevenge() : TutorialInfo
      {
         var _loc3_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("rev","lmb");
         var _loc4_:String = "tutorial.step.10.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _loc2_ = createTutorialState("-1",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.CENTER_OF_SCREEN,new Point(-236,-140),false,true),null,null,true);
         _loc2_.additionalInfo["questId"] = 30;
         _loc2_.additionalInfo["stateIndexMapMember"] = 2;
         _loc2_.additionalInfo["stateIndexDeployUnit"] = 5;
         _loc2_.additionalInfo["stateIndexExplainBattleProgress"] = 7;
         _loc1_.states.push(_loc2_);
         var _loc5_:String;
         var _loc6_:String;
         _loc3_ = userInfo.abModeTutorial == ABMode.MODE_B ? (_loc5_ = "tutorial.step.11b.desc",peak.i18n.PText.INSTANCE.getText0(_loc5_)) : (_loc6_ = "tutorial.step.11.desc",peak.i18n.PText.INSTANCE.getText0(_loc6_));
         _loc2_ = createTutorialState("11",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE3,TutorialAlignmentReferenceType.BOTTOM_RIGHT,new Point(-750,-300),true),new TutorialPointedArea(true,TutorialAlignmentReferenceType.MENU_PANEL_WAR_BUTTON,MobileTutorialMaskContainer.NON_SIZED_RECTANGLE,TutorialArrowDirection.LEFT,TutorialPointedAreaShape.NONE,10),null,false);
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("12",null,null,null,false);
         _loc2_.additionalInfo["mapMemberId"] = "NPC_4";
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("13",null,new TutorialPointedArea(true,TutorialAlignmentReferenceType.MAP_TOWN_OPTIONS_MENU,new Rectangle(0,0,999,93),TutorialArrowDirection.LEFT,TutorialPointedAreaShape.ROUND_RECT,860),null,false);
         _loc1_.states.push(_loc2_);
         var _loc7_:String = "tutorial.step.14-alt.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         _loc2_ = createTutorialState("14",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE3,TutorialAlignmentReferenceType.CENTER_OF_SCREEN,new Point(-475,-125),true,true),new TutorialPointedArea(true,TutorialAlignmentReferenceType.TUTURIAL_DONE_BUTTON,new Rectangle(0,0,50,59),TutorialArrowDirection.RIGHT,TutorialPointedAreaShape.NONE),TutorialMask.BARELY_VISIBLE,false);
         _loc1_.states.push(_loc2_);
         var _loc8_:String = "m.tutorial.step.15-alt2.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         _loc2_ = createTutorialState("15",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE3,TutorialAlignmentReferenceType.BOTTOM_RIGHT,new Point(-545,-365)),new TutorialPointedArea(true,TutorialAlignmentReferenceType.COMBAT_MERC_DEPLOY_TAB_MERC_VIEW,MobileTutorialMaskContainer.NON_SIZED_RECTANGLE,TutorialArrowDirection.TOP,TutorialPointedAreaShape.NONE),TutorialMask.BARELY_VISIBLE,false);
         _loc2_.additionalInfo["unitTypeId"] = 10;
         _loc2_.additionalInfo["amountOfUnits"] = 20;
         _loc1_.states.push(_loc2_);
         var _loc9_:String = "m.tutorial.step.16.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         _loc2_ = createTutorialState("16",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.BOTTOM_RIGHT,new Point(-545,-365)),null,TutorialMask.NON_VISIBLE,false);
         _loc1_.states.push(_loc2_);
         var _loc10_:String = "tutorial.step.61.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         _loc2_ = createTutorialState("61",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.BATTLE_PROGRESS_BAR,new Point(-295,120),true,true),new TutorialPointedArea(true,TutorialAlignmentReferenceType.BATTLE_PROGRESS_BAR,new Rectangle(0,0,470,47),TutorialArrowDirection.BOTTOM,TutorialPointedAreaShape.ROUND_RECT,-98,-12),TutorialMask.BARELY_VISIBLE,false);
         _loc2_.additionalInfo["targetVal"] = 1;
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("17",null,new TutorialPointedArea(true,TutorialAlignmentReferenceType.MANDATORY_ACTION_BUTTON,MobileTutorialMaskContainer.NON_SIZED_RECTANGLE,TutorialArrowDirection.LEFT,TutorialPointedAreaShape.NONE),TutorialMask.NON_VISIBLE,false);
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("-1",null,null,TutorialMask.NON_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialLumberBlade() : TutorialInfo
      {
         var _loc3_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("lmb","wor");
         _loc2_ = createTutorialState("-1",null,null,TutorialMask.NON_VISIBLE,false);
         _loc2_.additionalInfo["questId"] = 60;
         _loc2_.additionalInfo["stateIndexSendRequest"] = 5;
         _loc1_.states.push(_loc2_);
         var _loc4_:String = "m.tutorial.step.18.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _loc2_ = createTutorialState("18",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.BOTTOM_LEFT,new Point(90,-380),true),null,TutorialMask.NON_VISIBLE,false);
         _loc2_.additionalInfo["buildingTypeId"] = 11;
         _loc2_.additionalInfo["taskId"] = 601;
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("-1",null,null,TutorialMask.NON_VISIBLE,true);
         _loc2_.additionalInfo["waitMiliseconds"] = 250;
         _loc1_.states.push(_loc2_);
         var _loc5_:String = "tutorial.step.19.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _loc2_ = createTutorialState("19",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.BOTTOM_LEFT,new Point(90,-380),true),null,TutorialMask.NON_VISIBLE,false);
         _loc2_.additionalInfo["buildingTypeId"] = 11;
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("20",null,new TutorialPointedArea(true,TutorialAlignmentReferenceType.MANDATORY_ACTION_BUTTON,MobileTutorialMaskContainer.NON_SIZED_RECTANGLE,TutorialArrowDirection.LEFT,TutorialPointedAreaShape.NONE),TutorialMask.BARELY_VISIBLE,false);
         _loc2_.additionalInfo["buildingTypeId"] = 11;
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("21",null,new TutorialPointedArea(true,TutorialAlignmentReferenceType.MANDATORY_ACTION_BUTTON,MobileTutorialMaskContainer.NON_SIZED_RECTANGLE,TutorialArrowDirection.LEFT,TutorialPointedAreaShape.NONE),TutorialMask.BARELY_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("-1",null,null,TutorialMask.BARELY_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         var _loc6_:String = "m.tutorial.step.22.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _loc2_ = createTutorialState("22",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.BOTTOM_LEFT,new Point(90,-380),true),null,TutorialMask.NON_VISIBLE,false);
         _loc2_.additionalInfo["buildingTypeId"] = 11;
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("23",null,null,null,false);
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("24",null,null,null,true);
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialExtraWorker() : TutorialInfo
      {
         var _loc3_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("wor","hq");
         var _loc4_:String = "tutorial.step.39.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _loc2_ = createTutorialState("39",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.WORKER_PANEL,new Point(-575,-30),true),new TutorialPointedArea(true,TutorialAlignmentReferenceType.WORKER_PANEL,new Rectangle(0,0,88,42),TutorialArrowDirection.LEFT,TutorialPointedAreaShape.ROUND_RECT),TutorialMask.NON_VISIBLE,false);
         _loc2_.additionalInfo["questId"] = 70;
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("40",null,new TutorialPointedArea(true,TutorialAlignmentReferenceType.BUY_EXTRA_WORKER,new Rectangle(20,184,230,63),TutorialArrowDirection.RIGHT,null,-30,15),TutorialMask.BARELY_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialHiringQuarters() : TutorialInfo
      {
         var _loc4_:String = null;
         var _loc3_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("hq","bed");
         var _loc2_:int = 401;
         _loc3_ = createTutorialState("-1",null,null,TutorialMask.BARELY_VISIBLE,false);
         _loc3_.additionalInfo["waitMiliseconds"] = 25;
         _loc3_.additionalInfo["stateIndexGoToQuest"] = 1;
         _loc1_.states.push(_loc3_);
         var _loc5_:String = "m.tutorial.step.25.desc";
         _loc4_ = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _loc3_ = createTutorialState("25",new TutorialWindow(true,_loc4_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.BOTTOM_LEFT,new Point(150,-300)),new TutorialPointedArea(true,TutorialAlignmentReferenceType.QUEST_PREVIEW_VIEW,MobileTutorialMaskContainer.NON_SIZED_RECTANGLE,TutorialArrowDirection.RIGHT,TutorialPointedAreaShape.NONE),TutorialMask.BARELY_VISIBLE,false);
         _loc3_.additionalInfo["questId"] = 40;
         _loc3_.additionalInfo["taskId"] = _loc2_;
         _loc1_.states.push(_loc3_);
         _loc3_ = createTutorialState("26",null,new TutorialPointedArea(true,TutorialAlignmentReferenceType.MANDATORY_ACTION_BUTTON,new Rectangle(0,0,549,140),TutorialArrowDirection.RIGHT,TutorialPointedAreaShape.ROUND_RECT,-166,33),TutorialMask.BARELY_VISIBLE,false);
         _loc3_.additionalInfo["taskId"] = _loc2_;
         _loc1_.states.push(_loc3_);
         _loc3_ = createTutorialState("-1",null,new TutorialPointedArea(true,TutorialAlignmentReferenceType.POP_UP_WINDOW,new Rectangle(185,94,165,59),TutorialArrowDirection.LEFT),TutorialMask.BARELY_VISIBLE,false);
         _loc1_.states.push(_loc3_);
         _loc3_ = createTutorialState("27",null,new TutorialPointedArea(true,TutorialAlignmentReferenceType.BUILD_SHOWCASE,new Rectangle(0,0,280,257),TutorialArrowDirection.RIGHT,TutorialPointedAreaShape.ROUND_RECT),TutorialMask.BARELY_VISIBLE,false);
         _loc3_.additionalInfo["buildingTypeId"] = 20;
         _loc1_.states.push(_loc3_);
         _loc3_ = createTutorialState("28",null,new TutorialPointedArea(true,TutorialAlignmentReferenceType.MANDATORY_ACTION_BUTTON,MobileTutorialMaskContainer.NON_SIZED_RECTANGLE,TutorialArrowDirection.LEFT,TutorialPointedAreaShape.NONE),TutorialMask.BARELY_VISIBLE,false);
         _loc1_.states.push(_loc3_);
         var _loc6_:String = "tutorial.step.29.desc";
         _loc4_ = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _loc3_ = createTutorialState("29",new TutorialWindow(true,_loc4_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.BOTTOM_LEFT,new Point(10,-300),true),null,TutorialMask.NON_VISIBLE,true);
         _loc1_.states.push(_loc3_);
         _loc3_ = createTutorialState("30",null,null,TutorialMask.NON_VISIBLE,false);
         _loc1_.states.push(_loc3_);
         _loc3_ = createTutorialState("31",null,new TutorialPointedArea(true,TutorialAlignmentReferenceType.MANDATORY_ACTION_BUTTON,new Rectangle(2,0,139,59),TutorialArrowDirection.LEFT,TutorialPointedAreaShape.ROUND_RECT),TutorialMask.BARELY_VISIBLE,false);
         _loc1_.states.push(_loc3_);
         _loc3_ = createTutorialState("32",null,new TutorialPointedArea(true,TutorialAlignmentReferenceType.MANDATORY_ACTION_BUTTON,MobileTutorialMaskContainer.NON_SIZED_RECTANGLE,TutorialArrowDirection.LEFT,TutorialPointedAreaShape.NONE),TutorialMask.BARELY_VISIBLE,true);
         _loc1_.states.push(_loc3_);
         return _loc1_;
      }
      
      private function createTutorialHireBedouinBrutes() : TutorialInfo
      {
         var _loc3_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("bed","flg");
         var _loc4_:String = "tutorial.step.34.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _loc2_ = createTutorialState("34",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.BOTTOM_LEFT,new Point(75,-365),true),null,TutorialMask.NON_VISIBLE,false);
         _loc2_.additionalInfo["questId"] = 40;
         _loc2_.additionalInfo["taskId"] = 402;
         _loc2_.additionalInfo["buildingTypeId"] = 20;
         _loc2_.additionalInfo["stateIndexHireUnit"] = 1;
         _loc1_.states.push(_loc2_);
         var _loc5_:String = "m.tutorial.step.36.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _loc2_ = createTutorialState("36",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.HIRING_MERC_VIEW,new Point(75,75),false),new TutorialPointedArea(true,TutorialAlignmentReferenceType.HIRING_MERC_VIEW,MobileTutorialMaskContainer.NON_SIZED_RECTANGLE,TutorialArrowDirection.LEFT,TutorialPointedAreaShape.NONE),null,true);
         _loc2_.additionalInfo["unitTypeId"] = 10;
         _loc2_.additionalInfo["amountOfUnits"] = 4;
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("37",null,new TutorialPointedArea(true,TutorialAlignmentReferenceType.MANDATORY_ACTION_BUTTON,MobileTutorialMaskContainer.NON_SIZED_RECTANGLE,TutorialArrowDirection.TOP,TutorialPointedAreaShape.NONE),TutorialMask.BARELY_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("38",null,new TutorialPointedArea(true,TutorialAlignmentReferenceType.MANDATORY_ACTION_BUTTON,MobileTutorialMaskContainer.NON_SIZED_RECTANGLE,TutorialArrowDirection.LEFT,TutorialPointedAreaShape.NONE),TutorialMask.NON_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialProtectionFlag() : TutorialInfo
      {
         var _loc3_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("flg",null);
         _loc2_ = createTutorialState("-1",null,new TutorialPointedArea(true,TutorialAlignmentReferenceType.SECONDARY_ACTION_BUTTON,MobileTutorialMaskContainer.NON_SIZED_RECTANGLE,TutorialArrowDirection.LEFT,TutorialPointedAreaShape.NONE),TutorialMask.NON_VISIBLE,false);
         _loc2_.additionalInfo["stateIndexSelectFriends"] = 1;
         _loc1_.states.push(_loc2_);
         _loc2_ = createTutorialState("42",null,new TutorialPointedArea(true,TutorialAlignmentReferenceType.MANDATORY_ACTION_BUTTON,MobileTutorialMaskContainer.NON_SIZED_RECTANGLE,TutorialArrowDirection.LEFT,TutorialPointedAreaShape.NONE),TutorialMask.NON_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         var _loc4_:String = "tutorial.step.43.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _loc2_ = createTutorialState("43",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.PROTECTION_PANEL,new Point(50,100),false,true),new TutorialPointedArea(true,TutorialAlignmentReferenceType.PROTECTION_PANEL,MobileTutorialMaskContainer.NON_SIZED_RECTANGLE,TutorialArrowDirection.RIGHT,TutorialPointedAreaShape.NONE),TutorialMask.BARELY_VISIBLE,true);
         _loc2_.additionalInfo["waitMiliseconds"] = 10000;
         _loc1_.states.push(_loc2_);
         var _loc5_:String = "tutorial.step.44.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _loc2_ = createTutorialState("44",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.CENTER_OF_SCREEN,new Point(-236,-140),false,true),null,TutorialMask.BARELY_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialHelpThorzain() : TutorialInfo
      {
         var _loc3_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("hlp",null);
         var _loc4_:String = "m.tutorial.step.45.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _loc2_ = createTutorialState("45",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.TOP_LEFT,new Point(240,150),false,true),null,TutorialMask.NON_VISIBLE,true);
         _loc2_.additionalInfo["mapMemberId"] = "NPC_5";
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialRPExplanationTypeStore() : TutorialInfo
      {
         var _loc3_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("rp_s",null);
         var _loc4_:String = "tutorial.step.55.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _loc2_ = createTutorialState("55-1",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.POP_UP_WINDOW,new Point(480,100),false,true),new TutorialPointedArea(true,TutorialAlignmentReferenceType.POP_UP_WINDOW,new Rectangle(386,10,49,46),TutorialArrowDirection.BOTTOM),TutorialMask.NON_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialRPExplanationTypeGainRP() : TutorialInfo
      {
         var _loc3_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("rp_g",null);
         var _loc4_:String = "tutorial.step.55.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _loc2_ = createTutorialState("55-2",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.RECON_POINTS_BAR,new Point(-450,75),true,true),new TutorialPointedArea(true,TutorialAlignmentReferenceType.RECON_POINTS_BAR,new Rectangle(0,0,49,46),TutorialArrowDirection.LEFT),TutorialMask.NON_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialFirstAttack() : TutorialInfo
      {
         var _loc3_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("fa",null);
         var _loc4_:String = "tutorial.step.56.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _loc2_ = createTutorialState("56",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.CENTER_OF_SCREEN,new Point(-236,-140),false,true),null,TutorialMask.BARELY_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialFirstRepair() : TutorialInfo
      {
         var _loc3_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("fr",null);
         _loc2_ = createTutorialState("-1",null,null,TutorialMask.NON_VISIBLE,false);
         _loc1_.states.push(_loc2_);
         var _loc4_:String = "tutorial.step.57.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _loc2_ = createTutorialState("57",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.POP_UP_WINDOW,new Point(-177,-187),true),new TutorialPointedArea(true,TutorialAlignmentReferenceType.POP_UP_WINDOW,new Rectangle(63,216,208,57),TutorialArrowDirection.LEFT,TutorialPointedAreaShape.ROUND_RECT),TutorialMask.NON_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialResourceFull() : TutorialInfo
      {
         var _loc3_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("rf",null);
         _loc2_ = createTutorialState("-1",null,null,TutorialMask.NON_VISIBLE,false);
         _loc1_.states.push(_loc2_);
         var _loc4_:String = "tutorial.step.58.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _loc2_ = createTutorialState("58",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.BOTTOM_RIGHT,new Point(-460,-280)),null,TutorialMask.NON_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialFirstLooter() : TutorialInfo
      {
         var _loc4_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("fl",null);
         var _loc3_:Object = {};
         _loc3_["ut_12"] = true;
         _loc3_["ut_18"] = true;
         _loc2_ = createTutorialState("-1",null,null,TutorialMask.NON_VISIBLE,false);
         _loc2_.additionalInfo["unitTypeIds"] = _loc3_;
         _loc1_.states.push(_loc2_);
         var _loc5_:String = "tutorial.step.59.desc";
         _loc4_ = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _loc2_ = createTutorialState("59",new TutorialWindow(true,_loc4_,TutorialGirlAssetType.POSE3,TutorialAlignmentReferenceType.BOTTOM_RIGHT,new Point(-400,-250)),null,TutorialMask.NON_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialExplainPartFromActivateBuilding() : TutorialInfo
      {
         var _loc3_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("ep_ab",null);
         var _loc4_:String = "tutorial.step.60.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _loc2_ = createTutorialState("60-1",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.POP_UP_WINDOW,new Point(460,240),false,true),null,TutorialMask.NON_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialExplainPartFromHireWorker() : TutorialInfo
      {
         var _loc3_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("ep_hw",null);
         var _loc4_:String = "tutorial.step.60.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _loc2_ = createTutorialState("60-2",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.POP_UP_WINDOW,new Point(460,240),false,true),null,TutorialMask.NON_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialExplainMaps() : TutorialInfo
      {
         var _loc3_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("em",null);
         var _loc4_:String = "tutorial.step.62.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _loc2_ = createTutorialState("62",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.BOTTOM_RIGHT,new Point(-500,-355),false,true),null,TutorialMask.NON_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         var _loc5_:String = "tutorial.step.63.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _loc2_ = createTutorialState("63",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.BOTTOM_RIGHT,new Point(-580,-400),true,true),new TutorialPointedArea(true,TutorialAlignmentReferenceType.MANDATORY_ACTION_BUTTON,MobileTutorialMaskContainer.NON_SIZED_RECTANGLE,TutorialArrowDirection.LEFT,TutorialPointedAreaShape.NONE),TutorialMask.NON_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialFirstPvP() : TutorialInfo
      {
         var _loc3_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("fpvp",null);
         _loc2_ = createTutorialState("-1",null,null,TutorialMask.NON_VISIBLE,false);
         _loc1_.states.push(_loc2_);
         var _loc4_:String = "tutorial.step.64.desc";
         _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _loc2_ = createTutorialState("64",new TutorialWindow(true,_loc3_,TutorialGirlAssetType.POSE1,TutorialAlignmentReferenceType.BOTTOM_RIGHT,new Point(-400,-300),false,true),null,TutorialMask.NON_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialFirstTank() : TutorialInfo
      {
         var _loc4_:String = null;
         var _loc2_:TutorialState = null;
         var _loc1_:TutorialInfo = new TutorialInfo("ft",null);
         var _loc3_:Object = {};
         _loc3_["ut_11"] = true;
         _loc2_ = createTutorialState("-1",null,null,TutorialMask.NON_VISIBLE,false);
         _loc2_.additionalInfo["unitTypeIds"] = _loc3_;
         _loc1_.states.push(_loc2_);
         var _loc5_:String = "tutorial.step.65.desc";
         _loc4_ = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _loc2_ = createTutorialState("65",new TutorialWindow(true,_loc4_,TutorialGirlAssetType.POSE3,TutorialAlignmentReferenceType.BOTTOM_RIGHT,new Point(-400,-250)),null,TutorialMask.NON_VISIBLE,true);
         _loc1_.states.push(_loc2_);
         return _loc1_;
      }
      
      private function createTutorialState(param1:String, param2:TutorialWindow, param3:TutorialPointedArea, param4:TutorialMask, param5:Boolean) : TutorialState
      {
         return new TutorialState(param1,param2,param3,param4,param5);
      }
   }
}

