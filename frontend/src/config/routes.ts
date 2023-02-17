import Home from '../pages/home'

type Ruta = {
    name: string
    path: string
    component: () => JSX.Element
}

export const rutas: Ruta[] = [
    {
        name: 'home',
        path: '/',
        component: Home,
    },
]
