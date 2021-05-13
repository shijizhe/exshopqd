import {createRouter, createWebHistory} from 'vue-router'
import Home from '../views/Home.vue'

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
            title:'账户信息'
        },
        // 懒加载
        component: () => import('../views/usercontrolview/userhome'),
        children:[
            {
                path:'center',
                component: () => import('../views/usercontrolview/account/Userprofile'),
                meta:{
                    title:'个人中心'
                }
            },
            {
                path:'password',
                component: () => import('../views/usercontrolview/account/Changepass'),
                meta:{
                    title:'修改密码'
                },
            },
            {
                path:'address',
                component: () => import('../views/usercontrolview/account/Address'),
                meta:{
                    title:'收货地址'
                }
            }
        ]
    },

]

const router = createRouter({
    history: createWebHistory(process.env.BASE_URL),
    routes
})

export default router
