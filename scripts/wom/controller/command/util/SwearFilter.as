package wom.controller.command.util
{
   import peak.i18n.PText;
   
   public class SwearFilter
   {
      
      private var _wholeWords:Vector.<String>;
      
      private var _insideWords:Vector.<String>;
      
      public function SwearFilter()
      {
         super();
         _wholeWords = new Vector.<String>();
         _insideWords = new Vector.<String>();
         init();
      }
      
      private function init() : void
      {
      }
      
      public function censorText(param1:String, param2:Boolean = true, param3:Boolean = true, param4:String = null) : String
      {
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         if(!param4)
         {
            var _loc7_:String = "ui.misc.swearreplacement";
            param4 = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         }
         if(param2 && _wholeWords)
         {
            _loc6_ = _loc5_ = uint(_wholeWords.length - 1);
            while(_loc6_ >= 0)
            {
               param1 = param1.replace(new RegExp("(\\b" + _wholeWords[_loc6_] + "\\b)","gi"),param4);
               _loc6_--;
            }
         }
         if(param3 && _insideWords)
         {
            _loc6_ = _loc5_ = uint(_insideWords.length - 1);
            while(_loc6_ >= 0)
            {
               param1 = param1.replace(new RegExp("(" + _insideWords[_loc6_] + ")","gi"),param4);
               _loc6_--;
            }
         }
         return param1;
      }
      
      public function checkCensoredWordExits(param1:String, param2:Boolean = true, param3:Boolean = true) : Vector.<String>
      {
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc4_:Array = [];
         if(param2 && _wholeWords)
         {
            _loc6_ = _loc5_ = uint(_wholeWords.length - 1);
            while(_loc6_ >= 0)
            {
               _loc4_ = _loc4_.concat(param1.match(new RegExp("(\\b" + _wholeWords[_loc6_] + "\\b)","gi")));
               _loc6_--;
            }
         }
         if(param3 && _insideWords)
         {
            _loc6_ = _loc5_ = uint(_insideWords.length - 1);
            while(_loc6_ >= 0)
            {
               _loc4_ = _loc4_.concat(param1.match(new RegExp("(" + _insideWords[_loc6_] + ")","gi")));
               _loc6_--;
            }
         }
         return Vector.<String>(_loc4_);
      }
      
      public function updateWordLists(param1:Vector.<String> = null, param2:Vector.<String> = null) : void
      {
         if(param1 != null)
         {
            _wholeWords = param1;
         }
         if(param2 != null)
         {
            _insideWords = param2;
         }
      }
   }
}

