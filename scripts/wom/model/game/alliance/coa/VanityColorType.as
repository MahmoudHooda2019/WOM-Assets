package wom.model.game.alliance.coa
{
   public class VanityColorType
   {
      
      public static const COLOR1:VanityColorType = new VanityColorType(1,15079962);
      
      public static const COLOR2:VanityColorType = new VanityColorType(2,16737792);
      
      public static const COLOR3:VanityColorType = new VanityColorType(3,15382018);
      
      public static const COLOR4:VanityColorType = new VanityColorType(4,1411075);
      
      public static const COLOR5:VanityColorType = new VanityColorType(5,2405389);
      
      public static const COLOR6:VanityColorType = new VanityColorType(6,8708108);
      
      public static const COLOR7:VanityColorType = new VanityColorType(7,351873);
      
      public static const COLOR8:VanityColorType = new VanityColorType(8,692162);
      
      public static const COLOR9:VanityColorType = new VanityColorType(9,5359089);
      
      public static const COLOR10:VanityColorType = new VanityColorType(10,7024267);
      
      public static const COLOR11:VanityColorType = new VanityColorType(11,10619843);
      
      public static const COLOR12:VanityColorType = new VanityColorType(12,15813331);
      
      public static const COLOR13:VanityColorType = new VanityColorType(13,6434831);
      
      public static const COLOR14:VanityColorType = new VanityColorType(14,10381638);
      
      public static const COLOR15:VanityColorType = new VanityColorType(15,14723460);
      
      public static const COLOR16:VanityColorType = new VanityColorType(16,1644825);
      
      public static const COLOR17:VanityColorType = new VanityColorType(17,8947848);
      
      public static const COLOR18:VanityColorType = new VanityColorType(18,16777215);
      
      public static const DEFAULT:VanityColorType = COLOR1;
      
      public static const DEFAULT_2:VanityColorType = COLOR18;
      
      public static const colorTypes:Array = [COLOR1,COLOR2,COLOR3,COLOR4,COLOR5,COLOR6,COLOR7,COLOR8,COLOR9,COLOR10,COLOR11,COLOR12,COLOR13,COLOR14,COLOR15,COLOR16,COLOR17,COLOR18];
      
      private var _id:int;
      
      private var _color:uint;
      
      public function VanityColorType(param1:int, param2:uint)
      {
         super();
         this._id = param1;
         this._color = param2;
      }
      
      public static function determineColorType(param1:uint) : VanityColorType
      {
         var _loc2_:VanityColorType = VanityColorType.DEFAULT;
         switch(param1)
         {
            case COLOR1.id:
               _loc2_ = VanityColorType.COLOR1;
               break;
            case COLOR2.id:
               _loc2_ = VanityColorType.COLOR2;
               break;
            case COLOR3.id:
               _loc2_ = VanityColorType.COLOR3;
               break;
            case COLOR4.id:
               _loc2_ = VanityColorType.COLOR4;
               break;
            case COLOR5.id:
               _loc2_ = VanityColorType.COLOR5;
               break;
            case COLOR6.id:
               _loc2_ = VanityColorType.COLOR6;
               break;
            case COLOR7.id:
               _loc2_ = VanityColorType.COLOR7;
               break;
            case COLOR8.id:
               _loc2_ = VanityColorType.COLOR8;
               break;
            case COLOR9.id:
               _loc2_ = VanityColorType.COLOR9;
               break;
            case COLOR10.id:
               _loc2_ = VanityColorType.COLOR10;
               break;
            case COLOR11.id:
               _loc2_ = VanityColorType.COLOR11;
               break;
            case COLOR12.id:
               _loc2_ = VanityColorType.COLOR12;
               break;
            case COLOR13.id:
               _loc2_ = VanityColorType.COLOR13;
               break;
            case COLOR14.id:
               _loc2_ = VanityColorType.COLOR14;
               break;
            case COLOR15.id:
               _loc2_ = VanityColorType.COLOR15;
               break;
            case COLOR16.id:
               _loc2_ = VanityColorType.COLOR16;
               break;
            case COLOR17.id:
               _loc2_ = VanityColorType.COLOR17;
               break;
            case COLOR18.id:
               _loc2_ = VanityColorType.COLOR18;
         }
         return _loc2_;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get color() : uint
      {
         return _color;
      }
   }
}

