module Scenes.Home.Components.Comp2.Model exposing (component)

{-| Component model

@docs component

-}

import Color exposing (Color)
import Lib.Base exposing (SceneMsg)
import Lib.UserData exposing (UserData)
import Messenger.Base exposing (UserEvent(..))
import Messenger.Component.Component exposing (ComponentInit, ComponentMatcher, ComponentStorage, ComponentUpdate, ComponentUpdateRec, ComponentView, ConcreteUserComponent, genComponent)
import Messenger.Coordinate.Coordinates exposing (judgeMouseRect)
import Messenger.GeneralModel exposing (Msg(..), MsgBase(..))
import REGL.BuiltinPrograms as P
import Scenes.Home.Components.ComponentBase exposing (BaseData, ComponentMsg(..), ComponentTarget)
import Scenes.Home.SceneBase exposing (SceneCommonData)


type alias Data =
    {}


init : ComponentInit SceneCommonData UserData ComponentMsg Data BaseData
init env initMsg =
    ( {}, { order = 0, id = 0, color = Color.red } )


update : ComponentUpdate SceneCommonData Data UserData SceneMsg ComponentTarget ComponentMsg BaseData
update env evnt data basedata =
    case evnt of
        Tick _ ->
            let
                newMsg =
                    if judgeMouseRect env.globalData.mousePos ( 960, 900 ) ( 100, 100 ) then
                        [ Parent (OtherMsg PromptBoxOrderForWard) ]

                    else
                        []
            in
            ( ( data, basedata ), newMsg, ( env, False ) )

        _ ->
            ( ( data, basedata ), [], ( env, False ) )


updaterec : ComponentUpdateRec SceneCommonData Data UserData SceneMsg ComponentTarget ComponentMsg BaseData
updaterec env msg data basedata =
    ( ( data, basedata ), [], env )


view : ComponentView SceneCommonData UserData Data BaseData
view env data basedata =
    ( P.rect ( 960, 900 ) ( 100, 100 ) basedata.color, 0 )


matcher : ComponentMatcher Data BaseData ComponentTarget
matcher data basedata tar =
    tar == "Comp2"


componentcon : ConcreteUserComponent Data SceneCommonData UserData ComponentTarget ComponentMsg BaseData SceneMsg
componentcon =
    { init = init
    , update = update
    , updaterec = updaterec
    , view = view
    , matcher = matcher
    }


{-| Component generator
-}
component : ComponentStorage SceneCommonData UserData ComponentTarget ComponentMsg BaseData SceneMsg
component =
    genComponent componentcon
