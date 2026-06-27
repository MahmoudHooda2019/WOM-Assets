package wom.service.messaging
{
   import flash.utils.Dictionary;
   import org.robotlegs.mvcs.Actor;
   import peak.i18n.PText;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.view.screen.popups.GenericActionPopUp;
   import wom.view.screen.popups.MobileClementineChangableActionPopUp;
   import wom.view.screen.popups.apologies.ActionNotPossiblePopUp;
   import wom.view.screen.popups.apologies.MobileActionNotPossiblePopup;
   import wom.view.util.MobileGenericWindow;
   
   public class ErrorCodeRepository extends Actor
   {
      
      public static const BANK_RESOURCES_RESPONSE:String = "BankResourcesResponse";
      
      public static const CONSTRUCT_BUILDING_RESPONSE:String = "ConstructBuildingResponse";
      
      public static const EVOLVE_BEAST_RESPONSE:String = "EvolveBeastResponse";
      
      public static const FORTIFY_BUILDING_RESPONSE:String = "FortifyBuildingResponse";
      
      public static const FREEZE_BEAST_RESPONSE:String = "FreezeBeastResponse";
      
      public static const THAW_BEAST_RESPONSE:String = "ThawBeastResponse";
      
      public static const TRAIN_BEAST_RESPONSE:String = "TrainBeastResponse";
      
      public static const HEAL_BEAST_RESPONSE:String = "HealBeastResponse";
      
      public static const ALLIANCE:String = "Alliance";
      
      public static const TAVERN:String = "Tavern";
      
      private var messageTypeToErrorsMapArray:Dictionary;
      
      public function ErrorCodeRepository()
      {
         super();
         messageTypeToErrorsMapArray = new Dictionary();
         var _temp_4:* = messageTypeToErrorsMapArray;
         var _temp_3:* = "BankResourcesResponse";
         var _temp_2:* = String(22);
         var _loc1_:String = "ui.error.bankresources.22.desc";
         _temp_4[_temp_3] = {_temp_2:[peak.i18n.PText.INSTANCE.getText0(_loc1_)]};
         var _temp_9:* = messageTypeToErrorsMapArray;
         var _temp_8:* = "ConstructBuildingResponse";
         var _temp_7:* = String(9);
         var _loc2_:String = "ui.error.construct.9.desc";
         var _temp_6:* = [peak.i18n.PText.INSTANCE.getText0(_loc2_)];
         var _temp_5:* = String(13);
         var _loc3_:String = "ui.error.construct.13.desc";
         _temp_9[_temp_8] = {
            _temp_7:_temp_6,
            _temp_5:[peak.i18n.PText.INSTANCE.getText0(_loc3_)]
         };
         var _temp_12:* = messageTypeToErrorsMapArray;
         var _temp_11:* = "EvolveBeastResponse";
         var _temp_10:* = String(15);
         var _loc4_:String = "ui.error.evolvebeast.15.desc";
         _temp_12[_temp_11] = {_temp_10:[peak.i18n.PText.INSTANCE.getText0(_loc4_)]};
         var _temp_15:* = messageTypeToErrorsMapArray;
         var _temp_14:* = "FortifyBuildingResponse";
         var _temp_13:* = String(5);
         var _loc5_:String = "ui.error.fortify.5.desc";
         _temp_15[_temp_14] = {_temp_13:[peak.i18n.PText.INSTANCE.getText0(_loc5_)]};
         var _temp_18:* = messageTypeToErrorsMapArray;
         var _temp_17:* = "FreezeBeastResponse";
         var _temp_16:* = String(11);
         var _loc6_:String = "ui.error.freezebeast.11.desc";
         _temp_18[_temp_17] = {_temp_16:[peak.i18n.PText.INSTANCE.getText0(_loc6_)]};
         var _temp_21:* = messageTypeToErrorsMapArray;
         var _temp_20:* = "ThawBeastResponse";
         var _temp_19:* = String(2);
         var _loc7_:String = "ui.error.thawbeast.2.desc";
         _temp_21[_temp_20] = {_temp_19:[peak.i18n.PText.INSTANCE.getText0(_loc7_)]};
         var _temp_24:* = messageTypeToErrorsMapArray;
         var _temp_23:* = "TrainBeastResponse";
         var _temp_22:* = String(15);
         var _loc8_:String = "ui.error.trainbeast.15.desc";
         _temp_24[_temp_23] = {_temp_22:[peak.i18n.PText.INSTANCE.getText0(_loc8_)]};
         var _temp_27:* = messageTypeToErrorsMapArray;
         var _temp_26:* = "HealBeastResponse";
         var _temp_25:* = String(15);
         var _loc9_:String = "ui.error.healbeast.15.desc";
         _temp_27[_temp_26] = {_temp_25:[peak.i18n.PText.INSTANCE.getText0(_loc9_)]};
         var _temp_74:* = messageTypeToErrorsMapArray;
         var _temp_73:* = "Alliance";
         var _temp_72:* = String(1);
         var _loc10_:String = "ui.error.alliance.1.desc";
         var _temp_71:* = [peak.i18n.PText.INSTANCE.getText0(_loc10_)];
         var _temp_70:* = String(2);
         var _loc11_:String = "ui.error.alliance.2.desc";
         var _temp_69:* = [peak.i18n.PText.INSTANCE.getText0(_loc11_)];
         var _temp_68:* = String(3);
         var _loc12_:String = "ui.error.alliance.3.desc";
         var _temp_67:* = [peak.i18n.PText.INSTANCE.getText0(_loc12_)];
         var _temp_66:* = String(4);
         var _loc13_:String = "ui.error.alliance.4.desc";
         var _temp_65:* = [peak.i18n.PText.INSTANCE.getText0(_loc13_)];
         var _temp_64:* = String(5);
         var _loc14_:String = "ui.error.alliance.5.desc";
         var _temp_63:* = [peak.i18n.PText.INSTANCE.getText0(_loc14_)];
         var _temp_62:* = String(6);
         var _loc15_:String = "ui.error.alliance.6.desc";
         var _temp_61:* = [peak.i18n.PText.INSTANCE.getText0(_loc15_)];
         var _temp_60:* = String(7);
         var _loc16_:String = "ui.error.alliance.7.desc";
         var _temp_59:* = [peak.i18n.PText.INSTANCE.getText0(_loc16_)];
         var _temp_58:* = String(8);
         var _loc17_:String = "ui.error.alliance.8.desc";
         var _temp_57:* = [peak.i18n.PText.INSTANCE.getText0(_loc17_)];
         var _temp_56:* = String(9);
         var _loc18_:String = "ui.error.alliance.9.desc";
         var _temp_55:* = [peak.i18n.PText.INSTANCE.getText0(_loc18_)];
         var _temp_54:* = String(10);
         var _loc19_:String = "ui.error.alliance.10.desc";
         var _temp_53:* = [peak.i18n.PText.INSTANCE.getText0(_loc19_)];
         var _temp_52:* = String(11);
         var _loc20_:String = "ui.error.alliance.11.desc";
         var _temp_51:* = [peak.i18n.PText.INSTANCE.getText0(_loc20_)];
         var _temp_50:* = String(12);
         var _loc21_:String = "ui.error.alliance.12.desc";
         var _temp_49:* = [peak.i18n.PText.INSTANCE.getText0(_loc21_)];
         var _temp_48:* = String(13);
         var _loc22_:String = "ui.error.alliance.13.desc";
         var _temp_47:* = [peak.i18n.PText.INSTANCE.getText0(_loc22_)];
         var _temp_46:* = String(14);
         var _loc23_:String = "ui.error.alliance.14.desc";
         var _temp_45:* = [peak.i18n.PText.INSTANCE.getText0(_loc23_)];
         var _temp_44:* = String(15);
         var _loc24_:String = "ui.error.alliance.15.desc";
         var _temp_43:* = [peak.i18n.PText.INSTANCE.getText0(_loc24_)];
         var _temp_42:* = String(16);
         var _loc25_:String = "ui.error.alliance.16.desc";
         var _temp_41:* = [peak.i18n.PText.INSTANCE.getText0(_loc25_)];
         var _temp_40:* = String(17);
         var _loc26_:String = "ui.error.alliance.17.desc";
         var _temp_39:* = [peak.i18n.PText.INSTANCE.getText0(_loc26_)];
         var _temp_38:* = String(18);
         var _loc27_:String = "ui.error.alliance.18.desc";
         var _temp_37:* = [peak.i18n.PText.INSTANCE.getText0(_loc27_)];
         var _temp_36:* = String(19);
         var _loc28_:String = "ui.error.alliance.19.desc";
         var _temp_35:* = [peak.i18n.PText.INSTANCE.getText0(_loc28_)];
         var _temp_34:* = String(20);
         var _loc29_:String = "ui.error.alliance.20.desc";
         var _temp_33:* = [peak.i18n.PText.INSTANCE.getText0(_loc29_)];
         var _temp_32:* = String(21);
         var _loc30_:String = "ui.error.alliance.21.desc";
         var _temp_31:* = [peak.i18n.PText.INSTANCE.getText0(_loc30_)];
         var _temp_30:* = String(22);
         var _loc31_:String = "ui.error.alliance.22.desc";
         var _temp_29:* = [peak.i18n.PText.INSTANCE.getText0(_loc31_)];
         var _temp_28:* = String(28);
         var _loc32_:String = "ui.error.alliance.28.desc";
         _temp_74[_temp_73] = {
            _temp_72:_temp_71,
            _temp_70:_temp_69,
            _temp_68:_temp_67,
            _temp_66:_temp_65,
            _temp_64:_temp_63,
            _temp_62:_temp_61,
            _temp_60:_temp_59,
            _temp_58:_temp_57,
            _temp_56:_temp_55,
            _temp_54:_temp_53,
            _temp_52:_temp_51,
            _temp_50:_temp_49,
            _temp_48:_temp_47,
            _temp_46:_temp_45,
            _temp_44:_temp_43,
            _temp_42:_temp_41,
            _temp_40:_temp_39,
            _temp_38:_temp_37,
            _temp_36:_temp_35,
            _temp_34:_temp_33,
            _temp_32:_temp_31,
            _temp_30:_temp_29,
            _temp_28:[peak.i18n.PText.INSTANCE.getText0(_loc32_)]
         };
         var _temp_77:* = messageTypeToErrorsMapArray;
         var _temp_76:* = "Tavern";
         var _temp_75:* = String(3);
         var _loc33_:String = "ui.error.tavern.spin.3.desc";
         _temp_77[_temp_76] = {_temp_75:[peak.i18n.PText.INSTANCE.getText0(_loc33_)]};
      }
      
      public function dispatchError(param1:String, param2:int, param3:Class = null, param4:String = null) : Boolean
      {
         var _loc5_:Object = null;
         var _loc6_:MobileGenericWindow = null;
         _loc5_ = getErrorMessageFromTypeAndCode(param1,param2);
         if(_loc5_ != null)
         {
            if(param3 == null)
            {
               param3 = ActionNotPossiblePopUp;
            }
            if(param4 == null)
            {
               var _loc7_:String = "ui.error.oops";
               param4 = peak.i18n.PText.INSTANCE.getText0(_loc7_);
            }
            if(param3 == GenericActionPopUp)
            {
               _loc6_ = new MobileClementineChangableActionPopUp(2,param4,_loc5_[0]);
            }
            else
            {
               _loc6_ = new MobileActionNotPossiblePopup(-1,2,_loc5_[0]);
            }
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",_loc6_));
            return true;
         }
         return false;
      }
      
      private function getErrorMessageFromTypeAndCode(param1:String, param2:int) : Object
      {
         var _loc3_:Object = null;
         try
         {
            _loc3_ = messageTypeToErrorsMapArray[param1];
            return _loc3_[param2];
         }
         catch(e:Error)
         {
            log(LoggerContexts.INFRASTRUCTURE,"No error message for the type is specified : " + param1 + "." + param2.toString());
         }
         return null;
      }
   }
}

