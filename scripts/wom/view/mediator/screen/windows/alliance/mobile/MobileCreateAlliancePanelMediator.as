package wom.view.mediator.screen.windows.alliance.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.display.ExternalTextInputEvent;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.alliance.BrowseAllianceEvent;
   import wom.controller.event.alliance.MyAllianceEvent;
   import wom.controller.event.alliance.coa.VanityColorSelectionEvent;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.message.request.alliance.CreateAllianceRequest;
   import wom.model.message.request.alliance.EditAllianceRequest;
   import wom.view.screen.windows.alliance.mobile.MobileCreateAlliancePanel;
   
   public class MobileCreateAlliancePanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileCreateAlliancePanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      public function MobileCreateAlliancePanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.saveButton,"triggered",onSaveClicked,Event);
         eventMap.mapStarlingListener(view.cancelButton,"triggered",onCancelClicked,Event);
         eventMap.mapStarlingListener(view.allianceNameInput,"change",onConfirmEnablingCriteriaChange,Event);
         eventMap.mapStarlingListener(view.allianceNameInput,"focusOut",onFocusOutOfAllianceNameInput,Event);
         eventMap.mapStarlingListener(view.minScoreInput,"change",onConfirmEnablingCriteriaChange,Event);
         eventMap.mapStarlingListener(view.minLevelInput,"change",onConfirmEnablingCriteriaChange,Event);
         eventMap.mapStarlingListener(view.minScoreCheckBox,"change",onMinScoreCheckboxChanged,Event);
         eventMap.mapStarlingListener(view.minLevelCheckBox,"change",onMinLevelCheckboxChanged,Event);
         eventMap.mapStarlingListener(view.membershipTypeRadioGroup,"change",onMembershipTypeChange,Event);
         eventMap.mapStarlingListener(view.descriptionTextArea,"change",onDescriptionUpdated,Event);
         addContextListener("selectorPaletteOpened",onPaletteShown,VanityColorSelectionEvent);
         addContextListener("closePalette",onColorSelectedFromPalette,VanityColorSelectionEvent);
         view.onMembershipTypeSelectionUpdated();
         if(view.editModeOn)
         {
            view.updateWithAllianceInfo(allianceInfo.myAlliance);
            addContextListener("allianceInfoUpdated",onAllianceDetailsUpdated,ModelUpdateEvent);
         }
         addContextListener("externalTextInputUpdated",onExternalTextInputUpdated,ExternalTextInputEvent);
      }
      
      private function onAllianceDetailsUpdated(param1:ModelUpdateEvent) : void
      {
         view.updateWithAllianceInfo(allianceInfo.myAlliance);
      }
      
      private function onConfirmEnablingCriteriaChange(param1:Event) : void
      {
         view.checkConfirmButtonEnabling();
      }
      
      private function onFocusOutOfAllianceNameInput(param1:Event) : void
      {
         view.allianceNameInput.text = view.allianceNameInput.text.toUpperCase();
      }
      
      private function onMinScoreCheckboxChanged(param1:Event) : void
      {
         view.checkConfirmButtonEnabling(true);
      }
      
      private function onMinLevelCheckboxChanged(param1:Event) : void
      {
         view.checkConfirmButtonEnabling(false,true);
      }
      
      private function onMembershipTypeChange(param1:Event) : void
      {
         view.onMembershipTypeSelectionUpdated();
      }
      
      private function descriptionUpdated() : void
      {
         view.checkDescriptionLineLength();
      }
      
      private function onDescriptionUpdated(param1:Event) : void
      {
         descriptionUpdated();
      }
      
      private function onSaveClicked(param1:Event) : void
      {
         if(view.editModeOn)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new EditAllianceRequest(view.getAllianceInfo())));
         }
         else
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new CreateAllianceRequest(view.getAllianceInfo())));
         }
      }
      
      private function onCancelClicked(param1:Event) : void
      {
         if(view.editModeOn)
         {
            view.updateWithAllianceInfo(allianceInfo.myAlliance);
            dispatch(new MyAllianceEvent("navigateMyAllianceGeneralInfo"));
         }
         else
         {
            dispatch(new BrowseAllianceEvent("backToAlliances",null));
         }
      }
      
      private function onPaletteShown(param1:VanityColorSelectionEvent) : void
      {
         view.descriptionTextArea.isFocusEnabled = false;
      }
      
      private function onColorSelectedFromPalette(param1:VanityColorSelectionEvent) : void
      {
         view.descriptionTextArea.isFocusEnabled = true;
      }
      
      private function onExternalTextInputUpdated(param1:ExternalTextInputEvent) : void
      {
      }
   }
}

