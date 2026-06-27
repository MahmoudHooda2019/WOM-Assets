package wom.model.game.building
{
   public class BuildMenuDecorationCategory
   {
      
      public static const UNKNOWN:BuildMenuDecorationCategory = new BuildMenuDecorationCategory(0,"unknown");
      
      public static const FLAGS:BuildMenuDecorationCategory = new BuildMenuDecorationCategory(100,"flags");
      
      public static const LETTERS:BuildMenuDecorationCategory = new BuildMenuDecorationCategory(101,"letters");
      
      public static const OTHER:BuildMenuDecorationCategory = new BuildMenuDecorationCategory(102,"other");
      
      public static const categories:Array = [UNKNOWN,FLAGS,LETTERS,OTHER];
      
      private var _id:int;
      
      private var _name:String;
      
      public function BuildMenuDecorationCategory(param1:int, param2:String)
      {
         super();
         _id = param1;
         _name = param2;
      }
      
      public static function getCategory(param1:int) : BuildMenuDecorationCategory
      {
         switch(param1)
         {
            case FLAGS.id:
               return FLAGS;
            case LETTERS.id:
               return LETTERS;
            case OTHER.id:
               return OTHER;
            default:
               return UNKNOWN;
         }
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}

