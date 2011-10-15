/**
 *============================================================
 * copyright(c) 2011
 * @author  itoz
 * 2011/2011/09/25
 *============================================================
 */
package
{
    import flash.events.StageOrientationEvent;
    import flash.events.Event;
    import flash.desktop.NativeApplication;
    import flash.text.TextFieldType;
    import flash.text.TextField;
    import qnx.ui.buttons.LabelButton;

    import flash.display.Sprite;
    import flash.events.MouseEvent;

    /**
     * @author itoz
     */
    public class NotificationApp extends Sprite
    {
        private var _btn : LabelButton;
        private var _tf : TextField;
        public function NotificationApp()
        {
            _tf = addChild(new TextField()) as TextField;
            _tf.text = "HELLO ANE!";
            _tf.wordWrap = true;
            _tf.width = stage.stageWidth;
            _tf.multiline = false;
            _tf.type = TextFieldType.INPUT;
            _tf.border = true;
            _tf.borderColor = 0x000000;
            
            _btn= addChild(new LabelButton()) as LabelButton;
            _btn.label ="Show Notifycation";
            _btn.addEventListener(MouseEvent.CLICK, onTap);
            _btn.y = 100;
            addEventListener(Event.ADDED_TO_STAGE, onAdded);
        }

        private function onTap(event : MouseEvent) : void
        {
            var ni:NotificationInterface = new NotificationInterface();
            ni.notify(_tf.text);
        }
        
        private function onAdded(event : Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAdded);
            stage.addEventListener( Event.DEACTIVATE , onDeactivate );
            stage.addEventListener( Event.ACTIVATE , onActive );
            stage.addEventListener( Event.RESIZE , onResize );
            stage.addEventListener(StageOrientationEvent.ORIENTATION_CHANGE,onOrientationChange);
            
        }

        private function onOrientationChange(event : StageOrientationEvent) : void
        {
        }

        private function onResize(event : Event) : void
        {
        }

        private function onActive(event : Event) : void
        {
        }

        private function onDeactivate(event : Event) : void
        {
            NativeApplication.nativeApplication.exit();
        }
    }

}
