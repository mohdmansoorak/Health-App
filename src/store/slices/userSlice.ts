/**
 * User Slice
 */
import {createSlice, PayloadAction} from '@reduxjs/toolkit';

interface User {
  id: string;
  name: string;
  mobile: string;
  nationalId: string;
  policyNumber: string;
}

interface UserState {
  currentUser: User | null;
  loading: boolean;
  error: string | null;
}

const initialState: UserState = {
  currentUser: null,
  loading: false,
  error: null,
};

const userSlice = createSlice({
  name: 'user',
  initialState,
  reducers: {
    setUser: (state, action: PayloadAction<User>) => {
      state.currentUser = action.payload;
    },
    clearUser: state => {
      state.currentUser = null;
    },
  },
});

export const {setUser, clearUser} = userSlice.actions;
export default userSlice.reducer;
