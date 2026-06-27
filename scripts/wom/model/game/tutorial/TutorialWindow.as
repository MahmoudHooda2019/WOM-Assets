package wom.model.game.tutorial
{
   import flash.geom.Point;
   import wom.model.resource.asset.TutorialGirlAssetType;
   
   public class TutorialWindow
   {
      
      private var _enabled:Boolean;
      
      private var _textToBeShown:String;
      
      private var _alignmentReference:TutorialAlignmentReferenceType;
      
      private var _position:Point;
      
      private var _flipped:Boolean;
      
      private var _tutorialGirlAssetType:TutorialGirlAssetType;
      
      private var _doneButton:Boolean;
      
      public function TutorialWindow(param1:Boolean = false, param2:String = "", param3:TutorialGirlAssetType = null, param4:TutorialAlignmentReferenceType = null, param5:Point = null, param6:Boolean = false, param7:Boolean = false)
      {
         super();
         _enabled = param1;
         if(_enabled)
         {
            _textToBeShown = param2;
            _tutorialGirlAssetType = param3 != null ? param3 : TutorialGirlAssetType.POSE1;
            _alignmentReference = param4 != null ? param4 : TutorialAlignmentReferenceType.TOP_LEFT;
            _position = param5 != null ? param5 : new Point(0,0);
            _flipped = param6;
            _doneButton = param7;
         }
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function get textToBeShown() : String
      {
         return _textToBeShown;
      }
      
      public function get tutorialGirlAssetType() : TutorialGirlAssetType
      {
         return _tutorialGirlAssetType;
      }
      
      public function get alignmentReference() : TutorialAlignmentReferenceType
      {
         return _alignmentReference;
      }
      
      public function get position() : Point
      {
         return _position;
      }
      
      public function get flipped() : Boolean
      {
         return _flipped;
      }
      
      public function get doneButton() : Boolean
      {
         return _doneButton;
      }
   }
}

