module Scenes.Home.Layer2.Model exposing (layer)

{-| Layer configuration module

Set the Data Type, Init logic, Update logic, View logic and Matcher logic here.

@docs layer

-}

import Color exposing (Color)
import Lib.Base exposing (SceneMsg)
import Lib.UserData exposing (UserData)
import Messenger.Component.Component exposing (AbstractComponent, updateComponents, viewComponents)
import Messenger.GeneralModel exposing (AbstractGeneralModel(..), Matcher, Msg(..), MsgBase(..), unroll)
import Messenger.Layer.Layer exposing (ConcreteLayer, Handler, LayerInit, LayerStorage, LayerUpdate, LayerUpdateRec, LayerView, genLayer, handleComponentMsgs)
import Scenes.Home.Components.Comp1.Model as Comp1
import Scenes.Home.Components.Comp2.Model as Comp2
import Scenes.Home.Components.ComponentBase exposing (BaseData, ComponentMsg(..), ComponentTarget)
import Scenes.Home.SceneBase exposing (..)


type alias Data =
    { components : List (AbstractComponent SceneCommonData UserData ComponentTarget ComponentMsg BaseData SceneMsg)
    }


init : LayerInit SceneCommonData UserData LayerMsg Data
init env initMsg =
    Data
        [ Comp1.component (Comp1InitMsg { order = 1, id = 1, color = Color.blue }) env
        , Comp1.component (Comp1InitMsg { order = 0, id = 2, color = Color.green }) env
        , Comp2.component NullComponentMsg env
        ]


handleComponentMsg : Handler Data SceneCommonData UserData LayerTarget LayerMsg SceneMsg ComponentMsg
handleComponentMsg env compmsg data =
    case compmsg of
        SOMMsg som ->
            ( data, [ Parent <| SOMMsg som ], env )

        OtherMsg PromptBoxOrderForWard ->
            let
                newComponentList =
                    [ Comp1.component (Comp1InitMsg { order = 0, id = 1, color = Color.blue }) env
                    , Comp1.component (Comp1InitMsg { order = 1, id = 2, color = Color.green }) env
                    , Comp2.component NullComponentMsg env
                    ]
            in
            ( { data | components = newComponentList }, [], env )

        _ ->
            ( data, [], env )


update : LayerUpdate SceneCommonData UserData LayerTarget LayerMsg SceneMsg Data
update env evt data =
    let
        ( comps1, msgs1, ( env1, block1 ) ) =
            updateComponents env evt data.components

        ( data1, msgs2, env2 ) =
            handleComponentMsgs env1 msgs1 { data | components = comps1 } [] handleComponentMsg
    in
    ( data1, msgs2, ( env2, block1 ) )


updaterec : LayerUpdateRec SceneCommonData UserData LayerTarget LayerMsg SceneMsg Data
updaterec env msg data =
    ( data, [], env )


view : LayerView SceneCommonData UserData Data
view env data =
    viewComponents env data.components


matcher : Matcher Data LayerTarget
matcher data tar =
    tar == "Layer2"


layercon : ConcreteLayer Data SceneCommonData UserData LayerTarget LayerMsg SceneMsg
layercon =
    { init = init
    , update = update
    , updaterec = updaterec
    , view = view
    , matcher = matcher
    }


{-| Layer generator
-}
layer : LayerStorage SceneCommonData UserData LayerTarget LayerMsg SceneMsg
layer =
    genLayer layercon
