<template>
    <div class="my-2">
      <div>Username</div>
      <input
        v-model="form.username"
        id="username"
        placeholder="Username"
      />
    </div>
    <div class="my-2">
      <div>Password</div>
      <input
        v-model="form.password"
        id="password"
        placeholder="Password"
      />
    </div>
    <div class="text-danger my-2">{{ userStore.state.error }}</div>
    <button id="login" @click="onSubmit" class="btn btn-success btn-block my-2">
      Login
    </button>
</template>
<script lang="ts">
import { defineComponent, reactive } from 'vue';
import userStore from '@/stores/user';

export default defineComponent({
  setup() {
    const form = reactive({
      username: '',
      password: '',
    });

    const onSubmit = () => {
      userStore.login(form.username, form.password);
      form.username = '';
      form.password = '';
    };

    return { form, userStore, onSubmit };
  },
});
</script>
