import {createStore} from 'vuex'

export default createStore({
    state:{
        islog: false,
        user:{
            uid: null,
            uname:null,
            uavatar:null,
            uphone:null,
            urole:null,
            umail:null
        }

    },
    mutations: {
        setStateLogin(state,user){
            state.islog = true
            state.user.uid = user.uid
            state.user.uname = user.uname
            state.user.uphone = user.uphone
            state.user.uavatar = user.uavatar
            state.user.urole = user.urole
            state.user.umail = user.umail
        },
        setStateLogout(state){
            state.islog = false
            state.user.uid = null
            state.user.uname = null
            state.user.uphone = null
            state.user.uavatar =null
            state.user.umail = null
        }
    },
    actions: {},
    modules: {}
})
