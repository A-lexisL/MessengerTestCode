module Scenes.Home.Model exposing (scene)

{-| Scene configuration module

@docs scene

-}

import Lib.Base exposing (SceneMsg)
import Lib.UserData exposing (UserData)
import Messenger.Base exposing (Env, addCommonData)
import Messenger.Scene.LayeredScene exposing (LayeredSceneEffectFunc, LayeredSceneInit, genLayeredScene)
import Messenger.Scene.Scene exposing (SceneStorage)
import Scenes.Home.Layer1.Model as Layer1
import Scenes.Home.SceneBase exposing (..)


commonDataInit : Env () UserData -> Maybe SceneMsg -> SceneCommonData
commonDataInit _ _ =
    {}


init : LayeredSceneInit SceneCommonData UserData LayerTarget LayerMsg SceneMsg
init env msg =
    let
        cd =
            commonDataInit env msg

        envcd =
            addCommonData cd env
    in
    { renderSettings = []
    , commonData = cd
    , layers =
        [ Layer1.layer NullLayerMsg envcd ]
    }


settings : LayeredSceneEffectFunc SceneCommonData UserData LayerTarget LayerMsg SceneMsg
settings _ _ _ =
    []


{-| Scene generator
-}
scene : SceneStorage UserData SceneMsg
scene =
    genLayeredScene init settings
