package wom.controller.command.ui
{
   import flash.ui.Mouse;
   import wom.controller.PCommand;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.controller.event.ui.ActionSelectEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.component.enum.ActionType;
   import wom.model.component.enum.CanvasMode;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.building.BuildingInfo;
   import wom.view.screen.popups.apologies.ActionNotPossiblePopUp;
   
   public class ActionSelectCommand extends PCommand
   {
      
      private static var FORTIFICATION_AVAILABLE_LEVEL:int = 5;
      
      [Inject]
      public var event:ActionSelectEvent;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function ActionSelectCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:BuildingInfo = null;
         if(event.actionType == ActionType.FORTIFY)
         {
            for each(var _loc1_ in city.buildings)
            {
               if(_loc1_.buildingTypeId == 10)
               {
                  _loc2_ = _loc1_;
                  break;
               }
            }
            if(!(_loc2_ && _loc2_.level >= FORTIFICATION_AVAILABLE_LEVEL))
            {
               dispatch(new PopUpWindowEvent("showSecondaryPopUpWindow",new ActionNotPossiblePopUp(82)));
               dispatch(new ActionSelectEvent("selectionFailure",event.actionType));
               return;
            }
         }
         if(event.actionType != ActionType.BUILD)
         {
            gameRootHolder.gameRoot.exitBuildMode();
         }
         if(gameRootHolder.gameRoot.canvasMode == CanvasMode.MOVE)
         {
            gameRootHolder.gameRoot.cancelMove();
         }
         gameRootHolder.gameRoot.globalActionType = event.actionType;
         Mouse.cursor = event.actionType.visual;
         dispatch(new ActionSelectEvent("selectionSuccess",event.actionType));
         dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
      }
   }
}

