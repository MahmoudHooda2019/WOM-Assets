package wom.model
{
   public class SupportCategoryType
   {
      
      public static const GENERAL_ISSUES:SupportCategoryType = new SupportCategoryType(1,"m.ui.windows.contactsupport.categories.1");
      
      public static const PAYMENT_ISSUES:SupportCategoryType = new SupportCategoryType(2,"m.ui.windows.contactsupport.categories.2");
      
      public static const TECHNICAL_ISSUES:SupportCategoryType = new SupportCategoryType(3,"m.ui.windows.contactsupport.categories.3");
      
      public static const INVALID:SupportCategoryType = new SupportCategoryType(-1,"");
      
      public static const ALL_ISSUES:Vector.<SupportCategoryType> = new <SupportCategoryType>[GENERAL_ISSUES,PAYMENT_ISSUES,TECHNICAL_ISSUES];
      
      private var _id:int;
      
      private var _i18nKey:String;
      
      public function SupportCategoryType(param1:int, param2:String)
      {
         super();
         this._id = param1;
         this._i18nKey = param2;
      }
      
      public static function determineCategoryType(param1:int) : SupportCategoryType
      {
         var _loc2_:SupportCategoryType = INVALID;
         switch(param1)
         {
            case GENERAL_ISSUES._id:
               _loc2_ = GENERAL_ISSUES;
               break;
            case PAYMENT_ISSUES._id:
               _loc2_ = PAYMENT_ISSUES;
               break;
            case TECHNICAL_ISSUES._id:
               _loc2_ = TECHNICAL_ISSUES;
         }
         return _loc2_;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get i18nKey() : String
      {
         return _i18nKey;
      }
   }
}

