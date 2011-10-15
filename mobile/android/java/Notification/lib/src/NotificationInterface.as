/**
 *============================================================
 * copyright(c) 2011
 * @author  itoz
 * 2011/2011/09/25
 *============================================================
 */
package
{
    import flash.external.ExtensionContext;
    /**
     * @author itoz
     */
    public class NotificationInterface
    {
        private var context : ExtensionContext;
        
        public function NotificationInterface()
        {
            if (!context)
                context = ExtensionContext.createExtensionContext("jp.itoz.ane.notification", null);
        }

        public function notify(message : String) : void
        {
            context.call("notify", message);
        }
    }
}
