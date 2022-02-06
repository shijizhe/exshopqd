import {createRouter, createWebHistory} from 'vue-router'
import Home from '../views/Home.vue'
import store from "../store";
import {ElMessage} from "element-plus";

const routes = [
    {
        path: '/',
        name: 'Home',
        component: Home
    },
    {
        path: '/userhome',
        name: 'Userhome',
        meta:{
            title:'账户信息',
            requireAuth: true
        },
        // 懒加载
        component: () => import('../views/usercontrolview/userhome'),
        children:[
            {
                path:'center',
                component: () => import('../views/usercontrolview/account/Userprofile'),
                meta:{
                    title:'个人中心',
                    requireAuth: true
                }
            },
            {
                path:'password',
                component: () => import('../views/usercontrolview/account/Changepass'),
                meta:{
                    title:'修改密码',
                    requireAuth: true
                },
            },
            {
                path:'address',
                component: () => import('../views/usercontrolview/account/Address'),
                meta:{
                    title:'收货地址',
                    requireAuth: true
                }
            },
            {
                path:'myorder',
                component: () => import('../views/usercontrolview/account/MyOrder'),
                meta:{
                    title:'订单中心',
                    requireAuth: true
                }
            },
            {
                path:'mycharity',
                component: () => import('../views/usercontrolview/account/mycharity'),
                meta:{
                    title:'我的公益',
                    requireAuth: true
                }
            }
        ]
    },
    {
        path: "/:catchAll(.*)",
        name:'404',
        component: () => import('../views/404')
    }

]

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
})

router.beforeEach((to, from, next) => {
        if (to.meta.requireAuth) {
            if (store.state.user.uname) {
                console.log(store.state.user.uname)
                next()
            } else {
                ElMessage.info("非法访问，请先登录")
                next({
                    name:'Home'
                })
            }
        } else {
            next()
        }
    }
)


export default router
