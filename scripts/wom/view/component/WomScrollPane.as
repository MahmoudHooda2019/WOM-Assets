package wom.view.component
{
   import fl.controls.UIScrollBar;
   import peak.component.PScrollPane;
   
   public class WomScrollPane extends PScrollPane
   {
      
      public function WomScrollPane()
      {
         super();
         this.verticalScrollPolicy = "on";
         this.horizontalScrollPolicy = "off";
      }
      
      override protected function createScrollBar() : UIScrollBar
      {
         return new WomScrollBar();
      }
   }
}

