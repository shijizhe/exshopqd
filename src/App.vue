<template>

    <router-view/>
</template>

<script>

    export default {
        name: 'App',
        components: {},
        created() {
          //   在页面加载时读取sessionStorage里的状态信息
          if ( sessionStorage.getItem('state') ) {
            this.$store.replaceState( Object.assign( {}, this.$store.state,
                JSON.parse(sessionStorage.getItem('state') ) ) )
          }
          //页面刷新时将state数据存储到sessionStorage中
          window.addEventListener('beforeunload',()=>{
            sessionStorage.setItem('state',JSON.stringify(this.$store.state) )
          })

        }

    }
</script>

<style>

</style>
