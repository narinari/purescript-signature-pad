module Main where

import Graphics.SignaturePad
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import DOM (DOM)
import DOM.Event.EventTarget (eventListener, addEventListener)
import DOM.Event.Types (EventType(EventType))
import DOM.HTML (window)
import DOM.HTML.Types (htmlDocumentToNonElementParentNode)
import DOM.HTML.Window (document)
import DOM.Node.NonElementParentNode (getElementById)
import DOM.Node.Types (ElementId(ElementId), elementToEventTarget)
import Data.Either (either)
import Data.Foreign (toForeign)
import Data.Foreign.Class (read)
import Data.Maybe (Maybe(Nothing))
import Data.Nullable (toMaybe)
import Data.Traversable (sequence)

import Prelude (Unit, bind, void, pure, const, (<*>), (<$>), ($), (<<<), (=<<), (>>=))

foreign import onLoad :: forall eff. Eff eff Unit -> Eff eff Unit

clickEvent :: EventType
clickEvent = EventType "click"

main :: forall e. Eff (console :: CONSOLE, dom :: DOM | e) Unit
main = onLoad $ void $ do
  doc <- htmlDocumentToNonElementParentNode <$> (window >>= document)
  padElm <- toMaybe <$> getElementById (ElementId "sig1") doc
  clearElm <- toMaybe <$> getElementById (ElementId "clear") doc
  onElm <- toMaybe <$> getElementById (ElementId "on") doc
  offElm <- toMaybe <$> getElementById (ElementId "off") doc

  pad <- sequence $ mkSignaturePadSimple <$> ((eitherToMaybe <<< read <<< toForeign) =<< padElm)
  
  sequence $ setup <$> pad <*> clearElm <*> onElm <*> offElm

  where
  eitherToMaybe = either (const Nothing) pure
  setup pad clearElm onElm offElm = do
    addEventListener clickEvent (eventListener \_ -> clear pad) false $ elementToEventTarget clearElm
    addEventListener clickEvent (eventListener \_ -> on pad) false $ elementToEventTarget onElm
    addEventListener clickEvent (eventListener \_ -> off pad) false $ elementToEventTarget offElm

