module Main where

import Graphics.SignaturePad
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import DOM (DOM)
import DOM.Event.EventTarget (eventListener, addEventListener)
import DOM.Event.Types (EventType(EventType))
import DOM.HTML (window)
import DOM.HTML.Types (htmlDocumentToNonElementParentNode)
import DOM.HTML.Window (document)
import DOM.Node.NonElementParentNode (getElementById)
import DOM.Node.Types (Element, elementToEventTarget, ElementId(..))
import Data.Either (Either(Left, Right), either)
import Data.Foreign (toForeign)
import Data.Foreign.Class (read)
import Data.Maybe (Maybe, maybe)
import Data.Nullable (toMaybe)
import Data.Traversable (sequence)
import Graphics.SignaturePad.Types (SignaturePad)
import Prelude (class Show, Unit, id, void, show, bind, (<<<), (<$>), (>>=), ($))

foreign import onLoad :: forall eff. Eff eff Unit -> Eff eff Unit

main :: forall e. Eff (console :: CONSOLE, dom :: DOM | e) Unit
main = onLoad $ void $ do
  doc <- htmlDocumentToNonElementParentNode <$> (window >>= document)
  padElm <- toMaybe <$> getElementById (ElementId "sig1") doc
  clearElm <- toMaybe <$> getElementById (ElementId "clear") doc

  pad <- sequence $ mkSignaturePadSimple <$> (maybe (Left "Cannot find element.") (either' <<< read <<< toForeign) padElm)
  
  either log id $ pad >>= bindClearBtn clearElm

  where
  either' :: forall a b. Show a => Either a b -> Either String b
  either' = either (Left <<< show) Right
  bindClearBtn :: forall eff. Maybe Element -> SignaturePad -> Either String (Eff (dom :: DOM | eff) Unit)
  bindClearBtn elm pad =
    addEventListener (EventType "click") (eventListener \_ -> clear pad) false <$> (maybe (Left "Cannot find clear element.") (Right <<< elementToEventTarget) elm)

