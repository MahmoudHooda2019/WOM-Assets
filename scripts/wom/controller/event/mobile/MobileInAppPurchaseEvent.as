package wom.controller.event.mobile
{
   import flash.events.Event;
   
   public class MobileInAppPurchaseEvent extends Event
   {
      
      public static const SETUP:String = "setupMobileInAppPurchaseService";
      
      public static const MOBILE_PRODUCTS_LOADED:String = "mobileProductsLoaded";
      
      public static const RETREIVE_PRODUCTS_FROM_STORE:String = "retreiveProductsFromStore";
      
      public static const PREPARE_PURCHASE:String = "preparePurchase";
      
      public static const MAKE_PURCHASE:String = "makePurchase";
      
      public static const CONSUME_PURCHASE:String = "consumePurchase";
      
      private var _data:Object;
      
      public function MobileInAppPurchaseEvent(param1:String, param2:Object = null)
      {
         super(param1);
         _data = param2;
      }
      
      override public function clone() : Event
      {
         return new MobileInAppPurchaseEvent(type);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

