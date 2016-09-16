module Graphics.SignaturePad 
  ( mkSignaturePad
  , mkSignaturePadSimple
  , toDataURL
  , fromDataURL
  , clear
  , isEmpty
  , on
  , off
  ) where

import Prelude (Unit)

import Control.Monad.Eff (Eff)

import Data.Function.Eff (EffFn1, EffFn2, runEffFn1, runEffFn2)

import DOM (DOM)
import DOM.HTML.Types (HTMLCanvasElement)

import Graphics.SignaturePad.Types

foreign import mkSignaturePadImpl :: forall eff. EffFn2 (dom :: DOM | eff) HTMLCanvasElement Config SignaturePad
foreign import mkSignaturePadSimpleImpl :: forall eff. EffFn1 (dom :: DOM | eff) HTMLCanvasElement SignaturePad
foreign import toDataURLImpl :: forall eff. EffFn2 (dom :: DOM | eff) SignaturePad String String
foreign import fromDataURLImpl :: forall eff. EffFn2 (dom :: DOM | eff) SignaturePad String Unit
foreign import clearImpl :: forall eff. EffFn1 (dom :: DOM | eff) SignaturePad Unit
foreign import isEmptyImpl :: forall eff. EffFn1 (dom :: DOM | eff) SignaturePad Boolean
foreign import onImpl :: forall eff. EffFn1 (dom :: DOM | eff) SignaturePad Unit
foreign import offImpl :: forall eff. EffFn1 (dom :: DOM | eff) SignaturePad Unit

mkSignaturePad :: forall eff. HTMLCanvasElement -> Config -> Eff (dom :: DOM | eff) SignaturePad
mkSignaturePad = runEffFn2 mkSignaturePadImpl

mkSignaturePadSimple :: forall eff. HTMLCanvasElement -> Eff (dom :: DOM | eff) SignaturePad
mkSignaturePadSimple = runEffFn1 mkSignaturePadSimpleImpl

toDataURL :: forall eff. SignaturePad -> String -> Eff (dom :: DOM | eff) String
toDataURL = runEffFn2 toDataURLImpl

fromDataURL :: forall eff. SignaturePad -> String -> Eff (dom :: DOM | eff) Unit
fromDataURL = runEffFn2 fromDataURLImpl

clear :: forall eff. SignaturePad -> Eff (dom :: DOM | eff) Unit
clear = runEffFn1 clearImpl

isEmpty :: forall eff. SignaturePad -> Eff (dom :: DOM | eff) Boolean
isEmpty = runEffFn1 isEmptyImpl

on :: forall eff. SignaturePad -> Eff (dom :: DOM | eff) Unit
on = runEffFn1 onImpl

off :: forall eff. SignaturePad -> Eff (dom :: DOM | eff) Unit
off = runEffFn1 offImpl

